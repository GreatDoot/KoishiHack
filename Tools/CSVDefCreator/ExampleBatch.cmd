@echo off

@rem Make paths relative to the main buildfile folder
cd ..\..\

@rem Call the executable
@rem Usage: CSVDefCreator.exe PathToDefinitionsFolder PathToTable PathToTable PathToTable...
Tools\CSVDefCreator\CSVDefCreator.exe Definitions\ Tables\NightmareModules\CharactersClasses\CharacterTable.csv

@rem pause because executable doesn't automatically pause from expected execution; means it can be used in MAKE_HACK processes.
pause