-----------------------------------------------------------------------------
-- |
-- Module     : Control.Monad.Interleave
-- Copyright  : Copyright (c) , Patrick Perry <patperry@stanford.edu>
-- License    : BSD3
-- Maintainer : Patrick Perry <patperry@stanford.edu>
-- Stability  : experimental
--
-- Monads with an unsaveInterleaveIO-like operation.
--

module Control.Monad.Interleave (
    MonadInterleave(..),
    ) where

import Control.Monad.ST
import qualified Control.Monad.ST.Lazy as Lazy
import System.IO.Unsafe

-- | Monads that have an operation like 'unsafeInterleaveIO'.
class Monad m => MonadInterleave m where
    -- | Get the baton from the monad without doing any computation.
    unsafeInterleave :: m a -> m a

instance MonadInterleave IO where
    unsafeInterleave = unsafeInterleaveIO
    {-# INLINE unsafeInterleave #-}
    
instance MonadInterleave (ST s) where
    unsafeInterleave = unsafeInterleaveST
    {-# INLINE unsafeInterleave #-}
    
instance MonadInterleave (Lazy.ST s) where
    unsafeInterleave = Lazy.unsafeInterleaveST
    {-# INLINE unsafeInterleave #-}
