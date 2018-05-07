{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE StrictData #-}
module Main where

import Control.Applicative
import Control.Concurrent.STM
import Control.Monad
import qualified Data.ByteString.Lazy as BL
import qualified Data.Map.Strict as M
import Data.Monoid
import Data.String
import qualified Data.Text as T
import Data.Text.Encoding (decodeUtf8)
import Lucid
import Network.HTTP.Types
import Network.Mime
import Network.URI
import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger (logStdout)

type ServerState = M.Map T.Text User

data User = User
  { userName :: T.Text
  , userPassword :: T.Text
  , userProfilePic :: Maybe URI
  } deriving Show

defaultState :: ServerState
defaultState = M.singleton "admin" (User "admin" "Ib2z-qch2-Et04-O1bu" flagFile) -- Picture containing flag!
  where flagFile = parseURI "file:///flag.png"

main :: IO ()
main = do
  st <- newTVarIO defaultState
  runSettings settings (logStdout (app st))

settings :: Settings
settings = setHost "0.0.0.0" (setPort 8080 defaultSettings)

fetchFile :: URI -> IO Response
fetchFile uri = do
  let p = uriPath uri
  c <- BL.readFile p              -- lazy IO
  let !l = BL.toStrict (BL.take 20000000 c)
  pure (responseLBS status200 [("content-type", defaultMimeLookup (T.takeWhileEnd (/= '/') (T.pack p)))] (BL.fromStrict l))

fetchURI :: URI -> IO Response
fetchURI uri = case uriScheme uri of
  "https:" -> redirected
  "http:" -> redirected
  "file:" -> fetchFile uri
  _ -> pure generic404
  where redirected = pure $ responseLBS status307 [("Location", fromString (show uri))] mempty

generic404 :: Response
generic404 = responseLBS status404 [("content-type", "text/plain")] "404: Not Found\nDon't even think about it!"

userPage :: User -> Response
userPage User {..} =
  responseLBS status200 [("content-type", "text/html"), ("referrer-policy", "same-origin")] $
  renderBS $ do
    doctype_
    html_ $ do
      head_ $ do
        meta_ [charset_ "utf-8"]
        title_ "Saffy & Rosy Ice Cream - Profile Page"
        link_ [href_ "https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css", rel_ "stylesheet"]
        meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1, shrink-to-fit=no"]
      body_ $
        div_ [class_ "container"] $ do
          h1_ "Welcome to Saffy & Rosy Ice Cream!"
          p_ $ do
            "Hello "
            toHtml userName
            "!"
          div_ [class_ "media"] $ do
            img_ [class_ "mr-3", width_ "60", height_ "60", src_ ("/profile-pic/" <> userName)]
            div_ [class_ "media-body"] $ do
              h5_ [class_ "mt-0"] $ do
                toHtml userName
                ", proud member of Saffy & Rosy ice cream since 2018!"
              p_
                "Thank you for registering and becoming a member of Saffy & Rosy Ice Cream! We are delighted to serve you better."
          p_
            "Currently there are no promotions available to you, but we update our promotions every week! Check back later for promotions!"
          table_ [class_ "table"] $ do
            thead_ $
              tr_ $ do
                th_ [scope_ "col"] "#"
                th_ [scope_ "col"] "Available On"
                th_ [scope_ "col"] "Expire On"
                th_ [scope_ "col"] "Coupon Code"
                th_ [scope_ "col"] "Item"
            tbody_ $ tr_ $ td_ [colspan_ "5"] "0 records found"

mainPage :: Maybe String -> Response
mainPage msg =
  responseLBS status200 [("content-type", "text/html"), ("referrer-policy", "same-origin")] $
  renderBS $ do
    doctype_
    html_ $ do
      head_ $ do
        meta_ [charset_ "utf-8"]
        title_ "Saffy & Rosy Ice Cream"
        link_ [href_ "https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css", rel_ "stylesheet"]
        meta_ [name_ "viewport", content_ "width=device-width, initial-scale=1, shrink-to-fit=no"]
      body_ $
        div_ [class_ "container"] $ do
          h1_ "Welcome to Saffy & Rosy Ice Cream!"
          case msg of
            Nothing -> pure ()
            Just m -> p_ [style_ "background-color: #aaa"] $ strong_ (fromString m)
          h2_ "Sign Up Now"
          p_ "Sign up now at our newly renovated Saffy & Rosy Ice Cream site to get free coupons, promotions, and more!"
          form_ [method_ "post", action_ "/sign-up"] $
            div_ $ do
              div_ [class_ "form-group"] $ do
                label_ [for_ "username"] "Username* (lowercase letters & numbers only)"
                td_ $ input_ [class_ "form-control", type_ "text", name_ "username", placeholder_ "joebruin"]
              div_ [class_ "form-group"] $ do
                label_ [for_ "password1"] "Password*"
                td_ $ input_ [class_ "form-control", type_ "password", name_ "password1", placeholder_ "********"]
              div_ [class_ "form-group"] $ do
                label_ [for_ "password2"] "Confirm Password*"
                td_ $ input_ [class_ "form-control", type_ "password", name_ "password2", placeholder_ "********"]
              div_ [class_ "form-group"] $ do
                label_ [for_ "pic"] "Profile Picture URL (optional, PNG only, max 20MB)" -- This is the key to solving this CTF!
                td_ $ input_ [class_ "form-control", type_ "url", name_ "pic"]
              button_ [type_ "submit", class_ "btn btn-primary"] "Register Now!"
          h2_ "Log In"
          p_ "If you have already signed up, log in below to see if we have any new coupons for you!"
          form_ [method_ "post", action_ "/sign-in"] $
            div_ $ do
              div_ [class_ "form-group"] $ do
                label_ [for_ "username"] "Username*"
                td_ $ input_ [class_ "form-control", type_ "text", name_ "username", placeholder_ "joe.bruin"]
              div_ [class_ "form-group"] $ do
                label_ [for_ "password"] "Password*"
                td_ $ input_ [class_ "form-control", type_ "password", name_ "password", placeholder_ "********"]
              button_ [type_ "submit", class_ "btn btn-primary"] "Log In"

app :: TVar ServerState -> Application
app st req =
  (>>=) $
  case (requestMethod req, pathInfo req) of
    ("GET", []) -> pure $ responseLBS status301 [("location", "/index.html")] ""
    ("GET", ["sign-up"]) -> pure $ responseLBS status307 [("location", "/index.html")] ""
    ("GET", ["sign-in"]) -> pure $ responseLBS status307 [("location", "/index.html")] ""
    ("GET", ["index.html"]) -> pure $ mainPage Nothing
    ("GET", ["profile-pic", u])
      -- NO AUTHENTICATION HERE! GET THE FLAG NOW!
     -> do
      muser <- M.lookup u <$> readTVarIO st
      case muser of
        Nothing ->
          pure $ generic404
        Just User {userProfilePic = Nothing} ->
          pure $ responseFile status200 [("content-type", "image/svg+xml")] "./generic-user.svg" Nothing
        Just User {userProfilePic = Just url} -> fetchURI url
    ("POST", ["sign-up"]) -> do
      b <- strictRequestBody req
      let queries = parseSimpleQuery (BL.toStrict b)
          muser = do
            username <- decodeUtf8 <$> lookup "username" queries
            password1 <- decodeUtf8 <$> lookup "password1" queries
            password2 <- decodeUtf8 <$> lookup "password2" queries
            guard $ T.all (\c -> '0' <= c && c <= '9' || 'a' <= c && c <= 'z') username
            guard $ not $ T.null username
            guard $ not $ T.null password1
            guard $ not $ T.null password2
            guard $ password1 == password2
            profile <-
              case lookup "pic" queries of
                Nothing -> Just Nothing
                Just "" -> Just Nothing
                Just url -> fmap Just . parseURI . T.unpack . decodeUtf8 $ url
            pure (User username password1 profile)
      case muser of
        Just user ->
          atomically $ do
            exists <- M.member (userName user) <$> readTVar st
            if exists
              then pure $ mainPage (Just "This user name is already taken. Try again.")
              else do
                modifyTVar' st (M.insert (userName user) user)
                pure $ userPage user
        Nothing ->
          pure $
          mainPage $
          Just
            "Sign up unsuccessful. Did you complete all the fields on the form? Did you make sure \"Password\" and \"Confirm Password\" match?"
    ("POST", ["sign-in"]) -> do
      b <- strictRequestBody req
      let queries = parseSimpleQuery (BL.toStrict b)
          up = liftA2 (,) (decodeUtf8 <$> lookup "username" queries) (decodeUtf8 <$> lookup "password" queries)
      case up of
        Just (u, p) -- TIMING ATTACK???
         ->
          do
            muser <- M.lookup u <$> readTVarIO st
            case muser of
              Just user
                | userPassword user == p -> pure $ userPage user
              _ -> pure $ mainPage (Just "The username or password is wrong.")
        _ -> pure $ mainPage (Just "Please provide the user name and password.")
    _ -> pure $ generic404
