{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_meuprojeto (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/bin"
libdir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/lib/x86_64-linux-ghc-8.10.4/meuprojeto-0.1.0.0-LAhE9QEM6YV1gGc0BQe7lC-meuprojeto"
dynlibdir  = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/share/x86_64-linux-ghc-8.10.4/meuprojeto-0.1.0.0"
libexecdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/libexec/x86_64-linux-ghc-8.10.4/meuprojeto-0.1.0.0"
sysconfdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/meuprojeto/.stack-work/install/x86_64-linux-tinfo6/ff752b79de99d388e75c0922053d9938e475f7adedb9c36a2c1c72ff1d7c4e11/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "meuprojeto_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "meuprojeto_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "meuprojeto_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "meuprojeto_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "meuprojeto_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "meuprojeto_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
