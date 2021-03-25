{-# LANGUAGE OverloadedStrings #-}

module ListAll where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class ListAll a where
  listAll :: a -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance ListAll TableName where
  listAll Software conn               = query_ conn "SELECT * FROM software"
  listAll Type conn                   = query_ conn "SELECT * FROM type"
  listAll Author conn                 = query_ conn "SELECT * FROM author"
  listAll Users conn                  = query_ conn "SELECT * FROM users"
  listAll UseTerm conn                = query_ conn "SELECT * FROM use_term"
  listAll SoftwareUseTerms conn       = query_ conn "SELECT * FROM software_use_terms"
  listAll SoftwareUsageStatistic conn = query_ conn "SELECT * FROM software_usage_statistic"

listAllManager :: TableName -> MySQLConn -> IO ()
listAllManager tableName conn = do
  (defs, is) <- listAll tableName conn
  print ("id" : tableColumns tableName)
  mapM_ print =<< Streams.toList is
