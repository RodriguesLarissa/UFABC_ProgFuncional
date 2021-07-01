{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Monoid (
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

bindir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/bin"
libdir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/lib/x86_64-linux-ghc-8.10.4/Monoid-0.1.0.0-L5H345ckuicEJHnOeM0WIA-Monoid"
dynlibdir  = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/share/x86_64-linux-ghc-8.10.4/Monoid-0.1.0.0"
libexecdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/libexec/x86_64-linux-ghc-8.10.4/Monoid-0.1.0.0"
sysconfdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/UFABC_ProgFuncional/Monoid/.stack-work/install/x86_64-linux-tinfo6/fe9b200e22f538d47d37d7c5284922846d90bee168e5326992179001ef2006f9/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Monoid_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Monoid_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Monoid_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Monoid_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Monoid_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Monoid_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
