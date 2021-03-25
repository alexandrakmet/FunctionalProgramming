module Utils where

import           Data.Int
import           Data.Time

data TableName
  = Software
  | Type
  | Author
  | Users
  | UseTerm
  | SoftwareUseTerms
  | SoftwareUsageStatistic

tableNames :: [String]
tableNames = ["software", "type", "author", "users", "use_term", "software_use_terms", "software_usage_statistic"]

orderedTableNames :: [String]
orderedTableNames = ["1. software", "2. type", "3. author", "4. users", "5. use_term", "6. software_use_terms", "7. software_usage_statistic"]

numberToTableName :: String -> String
numberToTableName "1" = "software"
numberToTableName "2" = "type"
numberToTableName "3" = "author"
numberToTableName "4" = "users"
numberToTableName "5" = "use_term"
numberToTableName "6" = "software_use_terms"
numberToTableName "7" = "software_usage_statistic"
numberToTableName _   = "exit"

toNum :: String -> Int32
toNum str = fromInteger (read str :: Integer)

toDate :: String -> LocalTime
toDate dateStr = parseTimeOrError True defaultTimeLocale "%YYYY-%mm-%dd %H:%M" dateStr :: LocalTime

checkTableName :: String -> Bool
checkTableName name = name `elem` tableNames

tableColumns :: TableName -> [String]
tableColumns Software = ["name", "annotation", "version", "start_of_usage", "author_id", "type_id"]
tableColumns Type = ["name"]
tableColumns Author = ["name", "surname"]
tableColumns Users = ["name", "login", "registration_date"]
tableColumns UseTerm = ["name", "description"]
tableColumns SoftwareUseTerms = ["software_id", "use_term_id"]
tableColumns SoftwareUsageStatistic = ["software_id", "user_id", "logon_count"]

updatableTableColumns :: String -> [String]
updatableTableColumns "software" = ["name", "annotation", "version"]
updatableTableColumns "type" = ["name"]
updatableTableColumns "author" = ["name", "surname"]
updatableTableColumns "users" = ["name", "login"]
updatableTableColumns "use_term" = ["name", "description"]
updatableTableColumns "software_use_terms" = ["Can't be updated. Press enter to exit"]
updatableTableColumns "software_usage_statistic" = ["Can't be updated. Press enter to exit"]
updatableTableColumns x = []

checkUpdatableColumns :: String -> String -> Bool
checkUpdatableColumns tableName columnName = columnName `elem` updatableTableColumns tableName

getTableName :: String -> TableName
getTableName "software"                 = Software
getTableName "type"                     = Type
getTableName "author"                   = Author
getTableName "users"                    = Users
getTableName "use_term"                 = UseTerm
getTableName "software_use_terms"       = SoftwareUseTerms
getTableName "software_usage_statistic" = SoftwareUsageStatistic
