from dagster import Definitions
from .init import definition as init
from .transformation import definition as transformation

defs = Definitions.merge(
   init.defs, transformation.defs_test

)
