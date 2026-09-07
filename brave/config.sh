#!/bin/bash

PLIST_DOMAIN="com.brave.Browser"

defaults write "$PLIST_DOMAIN" "MetricsReportingEnabled" -bool false
defaults write "$PLIST_DOMAIN" "SafeBrowsingExtendedReportingEnabled" -bool false
defaults write "$PLIST_DOMAIN" "UrlKeyedAnonymizedDataCollectionEnabled" -bool false
defaults write "$PLIST_DOMAIN" "FeedbackSurveysEnabled" -bool false
defaults write "$PLIST_DOMAIN" "BraveRewardsDisabled" -bool true
defaults write "$PLIST_DOMAIN" "BraveWalletDisabled" -bool true
defaults write "$PLIST_DOMAIN" "BraveVPNDisabled" -bool true
defaults write "$PLIST_DOMAIN" "BraveAIChatEnabled" -bool false
defaults write "$PLIST_DOMAIN" "ShoppingListEnabled" -bool false
defaults write "$PLIST_DOMAIN" "AlwaysOpenPdfExternally" -bool true
#defaults write "$PLIST_DOMAIN" "TranslateEnabled" -bool false
#defaults write "$PLIST_DOMAIN" "SpellcheckEnabled" -bool false
defaults write "$PLIST_DOMAIN" "PromotionsEnabled" -bool false
