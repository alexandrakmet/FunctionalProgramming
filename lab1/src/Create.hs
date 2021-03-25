{-# LANGUAGE OverloadedStrings #-}

module Create where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Create a where
  createRow :: a -> [String] -> MySQLConn -> IO OK

instance Create TableName where
  createRow Software params conn =
    execute
      conn
      "INSERT INTO software (name, annotation, version, start_of_usage, author_id, type_id) VALUES(?,?,?,now(),?,?)"
      [ MySQLText (toText (head params))
      , MySQLText (toText (params !! 1))
      , MySQLText (toText (params !! 2))
      , MySQLInt32 (toNum (params !! 4))
      , MySQLInt32 (toNum (params !! 5))
      ]
  createRow Type params conn = execute conn "INSERT INTO type (name) VALUES(?)" [MySQLText (toText (head params))]
  createRow Author params conn =
    execute
      conn
      "INSERT INTO author (name,surname) VALUES(?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1))]
  createRow Users params conn =
    execute
      conn
      "INSERT INTO users (name, login, registration_date) VALUES(?,?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1)), MySQLDateTime(toDate (params !! 2))]
  createRow UseTerm params conn =
    execute
      conn
      "INSERT INTO use_term (name, description) VALUES(?,?)"
      [MySQLText (toText (head params)), MySQLText (toText (params !! 1))]
  createRow SoftwareUseTerms params conn =
    execute
      conn
      "INSERT INTO software_use_terms (software_id, use_term_id) VALUES(?,?)"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]
  createRow SoftwareUsageStatistic params conn =
    execute
      conn
      "INSERT INTO software_usage_statistic (software_id, user_id, logon_count) VALUES(?,?,?)"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1)), MySQLInt32 (toNum (params !! 2))]

createRowManager :: TableName -> MySQLConn -> IO ()
createRowManager tableName conn = do
  putStrLn "Enter column values, delimiter - [enter]:"
  putStrLn (intercalate "\n" (tableColumns tableName))
  case tableName of
    Software -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      field3 <- getLine
      field4 <- getLine
      field5 <- getLine
      createRow tableName [field0, field1, field2, field3, field4, field5] conn
    Type -> do
      field0 <- getLine
      createRow tableName [field0] conn
    Author -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    Users -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      createRow tableName [field0, field1, field2] conn
    UseTerm -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    SoftwareUsageStatistic -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      createRow tableName [field0, field1, field2] conn
    SoftwareUseTerms -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
  putStrLn "1 row inserted"
