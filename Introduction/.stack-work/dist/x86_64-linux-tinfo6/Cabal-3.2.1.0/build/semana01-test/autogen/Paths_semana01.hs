{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_semana01 (
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

bindir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/bin"
libdir     = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/lib/x86_64-linux-ghc-8.10.4/semana01-0.1.0.0-J8OGbdrNc7EJLSidxmtHvl-semana01-test"
dynlibdir  = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/lib/x86_64-linux-ghc-8.10.4"
datadir    = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/share/x86_64-linux-ghc-8.10.4/semana01-0.1.0.0"
libexecdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/libexec/x86_64-linux-ghc-8.10.4/semana01-0.1.0.0"
sysconfdir = "/home/larissa/UFABC/Paradigmas da Programa\231\227o/paradigmas-2021-q2-semana01-RodriguesLarissa/.stack-work/install/x86_64-linux-tinfo6/0060699540d8c261830654f0e7eb83ef9a1571c835df15c436b4224bc8278f68/8.10.4/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "semana01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "semana01_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "semana01_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "semana01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "semana01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "semana01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
