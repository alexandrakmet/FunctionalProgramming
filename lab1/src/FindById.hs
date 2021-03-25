{-# LANGUAGE OverloadedStrings #-}

module FindById where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class FindById a where
  findById :: a -> String -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance FindById TableName where
  findById Software index conn               = query conn "SELECT * FROM software WHERE id=?" [MySQLInt32 (toNum index)]
  findById Type index conn                   = query conn "SELECT * FROM type WHERE id=?" [MySQLInt32 (toNum index)]
  findById Author index conn                 = query conn "SELECT * FROM author WHERE id=?" [MySQLInt32 (toNum index)]
  findById Users index conn                  = query conn "SELECT * FROM users WHERE id=?" [MySQLInt32 (toNum index)]
  findById UseTerm index conn                = query conn "SELECT * FROM use_term WHERE id=?" [MySQLInt32 (toNum index)]
  findById SoftwareUseTerms index conn       = query conn "SELECT * FROM software_use_terms WHERE software_id=?" [MySQLInt32 (toNum index)]
  findById SoftwareUsageStatistic index conn =
    query conn "SELECT * FROM software_usage_statistic WHERE software_id=?" [MySQLInt32 (toNum index)]

findByManager :: TableName -> MySQLConn -> IO ()
findByManager tableName conn = do
  putStrLn "Enter id: "
  index <- getLine
  (defs, is) <- findById tableName index conn
  print ("id" : tableColumns tableName)
  print =<< Streams.toList is
