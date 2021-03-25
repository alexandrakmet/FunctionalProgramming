{-# LANGUAGE OverloadedStrings #-}

module Delete where

import           Database.MySQL.Base
import           Utils

class Delete a where
  deleteRow :: a -> [String] -> MySQLConn -> IO OK

instance Delete TableName where
  deleteRow Software params conn         = execute conn "DELETE FROM software WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Type params conn             = execute conn "DELETE FROM type WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Author params conn           = execute conn "DELETE FROM author WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Users params conn            = execute conn "DELETE FROM users WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow UseTerm params conn          = execute conn "DELETE FROM use_term WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow SoftwareUseTerms params conn =
    execute
      conn
      "DELETE FROM software_use_terms WHERE software_id=? and use_term_id=?"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]
  deleteRow SoftwareUsageStatistic params conn =
    execute
      conn
      "DELETE FROM software_usage_statistic WHERE software_id=? and user_id=?"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]

deleteRowManager :: TableName -> MySQLConn -> IO ()
deleteRowManager tableName conn = do
  case tableName of
    Software -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Type -> do
      putStrLn "Enter type id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Author -> do
      putStrLn "Enter author id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Users -> do
      putStrLn "Enter user id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    UseTerm -> do
      putStrLn "Enter use term id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    SoftwareUseTerms -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      putStrLn "Enter use term id: "
      field1 <- getLine
      deleteRow tableName [field0, field1] conn
    SoftwareUsageStatistic -> do
      putStrLn "Enter software id: "
      field0 <- getLine
      putStrLn "Enter user id: "
      field1 <- getLine
      deleteRow tableName [field0, field1] conn
  putStrLn "Row(s) deleted"
