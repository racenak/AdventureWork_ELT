from ..dagster_orchestration.transformation.resource import dbt_project_directory
import pytest
from dagster import build_asset_context, AssetCheckResult, asset_check
from unittest.mock import MagicMock
from ..dagster_orchestration.init.assets import raw_customer, create_stream_config

print(dbt_project_directory)
@pytest.fixture
def mock_sling():
    return MagicMock()

def test_raw_customer_config():
    config = create_stream_config("Sales.Customer", "raw_customer")
    assert isinstance(config, AssetCheckResult)
    assert config.config["source"] == "MY_SQLSERVER"
    assert config.config["target"] == "MY_CH"
    assert config.config["streams"]["Sales.Customer"]["object"] == "raw_customer"

@asset_check(asset_key=["raw_customer"])
def test_raw_customer_check(mock_sling):
    context = build_asset_context()
    
    # Configure mock behavior
    mock_sling.replicate.return_value = iter([{"status": "success"}])
    
    # Execute the asset
    result = list(raw_customer(context, mock_sling))
    
    # Verify the asset execution
    assert len(result) > 0
    mock_sling.replicate.assert_called_once_with(context=context, debug=True)

@asset_check(asset_key=["raw_customer"])
def test_raw_customer_check_failure(mock_sling):
    context = build_asset_context()
    
    # Configure mock to simulate failure
    mock_sling.replicate.side_effect = Exception("Replication failed")
    
    # Verify the asset raises an exception
    with pytest.raises(Exception):
        list(raw_customer(context, mock_sling))