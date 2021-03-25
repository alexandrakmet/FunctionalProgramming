{-# LANGUAGE OverloadedStrings #-}

module Update where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Update a where
  updateRow :: a -> String -> String -> String -> MySQLConn -> IO OK

instance Update TableName where
  updateRow Software "name" value index conn =
    execute conn "UPDATE software SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Software "annotation" value index conn =
    execute conn "UPDATE software SET annotation=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Software "version" value index conn =
    execute conn "UPDATE software SET version=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Type "name" value index conn =
    execute conn "UPDATE type SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Author "name" value index conn =
    execute conn "UPDATE author SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Author "surname" value index conn =
    execute conn "UPDATE author SET surname=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Users "name" value index conn =
    execute conn "UPDATE users SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Users "login" value index conn =
    execute conn "UPDATE users SET login=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow UseTerm "name" value index conn =
    execute conn "UPDATE use_term SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow UseTerm "description" value index conn =
    execute conn "UPDATE use_term SET description=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]

updateRowManager :: String -> MySQLConn -> IO ()
updateRowManager name conn =
  case name of
    "software_use_terms" -> putStrLn "This table can't be upated"
    "software_usage_statistic" -> putStrLn "This table can't be upated"
    _ -> do
      putStrLn "Update where row_id =  "
      index <- getLine
      putStrLn "Enter column: "
      putStrLn (intercalate "\n" (updatableTableColumns name))
      field <- getLine
      if checkUpdatableColumns name field
        then do
          putStrLn "New value: "
          value <- getLine
          updateRow (getTableName name) field value index conn
          putStrLn "1 row updated"
        else putStrLn "ERROR - Invalid identifier"
