package com.example.ads

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class CNativeAdFactory (private val context: Context) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.ad_unified, null) as NativeAdView

        with(nativeAdView) {

            // Set the media view.
            nativeAdView.mediaView = nativeAdView.findViewById<MediaView>(R.id.ad_media)

            // Set other ad assets.
            nativeAdView.headlineView = nativeAdView.findViewById(R.id.ad_headline)
            nativeAdView.bodyView = nativeAdView.findViewById(R.id.ad_body)
            nativeAdView.callToActionView = nativeAdView.findViewById(R.id.ad_call_to_action)
            nativeAdView.iconView = nativeAdView.findViewById(R.id.ad_app_icon)
            nativeAdView.priceView = nativeAdView.findViewById(R.id.ad_price)
            nativeAdView.starRatingView = nativeAdView.findViewById(R.id.ad_stars)
            nativeAdView.storeView = nativeAdView.findViewById(R.id.ad_store)
            nativeAdView.advertiserView = nativeAdView.findViewById(R.id.ad_advertiser)

            // The headline and media content are guaranteed to be in every UnifiedNativeAd.
            (nativeAdView.headlineView as TextView).text = nativeAd.headline
            nativeAdView.mediaView?.setMediaContent(nativeAd.mediaContent)

            // These assets aren't guaranteed to be in every UnifiedNativeAd, so it's important to
            // check before trying to display them.
            if (nativeAd.body == null) {
                nativeAdView.bodyView?.visibility = View.INVISIBLE
            } else {
                nativeAdView.bodyView?.visibility = View.VISIBLE
                (nativeAdView.bodyView as TextView).text = nativeAd.body
            }

            if (nativeAd.callToAction == null) {
                nativeAdView.callToActionView?.visibility = View.INVISIBLE
            } else {
                nativeAdView.callToActionView?.visibility = View.VISIBLE
                (nativeAdView.callToActionView as Button).text = nativeAd.callToAction
            }

            if (nativeAd.icon == null) {
                nativeAdView.iconView?.visibility = View.GONE
            } else {
                (nativeAdView.iconView as ImageView).setImageDrawable(
                    nativeAd.icon?.drawable
                )
                nativeAdView.iconView?.visibility = View.VISIBLE
            }

            if (nativeAd.price == null) {
                nativeAdView.priceView?.visibility = View.INVISIBLE
            } else {
                nativeAdView.priceView?.visibility = View.VISIBLE
                (nativeAdView.priceView as TextView).text = nativeAd.price
            }

            if (nativeAd.store == null) {
                nativeAdView.storeView?.visibility = View.INVISIBLE
            } else {
                nativeAdView.storeView?.visibility = View.VISIBLE
                (nativeAdView.storeView as TextView).text = "Available on ${nativeAd.store}"
            }

            if (nativeAd.starRating == null) {
                nativeAdView.starRatingView?.visibility = View.INVISIBLE
            } else {
                (nativeAdView.starRatingView as RatingBar).rating = nativeAd.starRating!!.toFloat()
                nativeAdView.starRatingView?.visibility = View.VISIBLE
            }

            if (nativeAd.advertiser == null) {
                nativeAdView.advertiserView?.visibility = View.INVISIBLE
            } else {
                (nativeAdView.advertiserView as TextView).text = nativeAd.advertiser
                nativeAdView.advertiserView?.visibility = View.VISIBLE
            }

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}