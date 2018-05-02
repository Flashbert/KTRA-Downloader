# KTRA-Downloader
Keeping the Rave Alive Downloader

Easy download for Keepingtheravealive-Podcast

.DESCRIPTION
    This script downloads KeepingTheRaveAlive Podcast from the website.
    You can either specify one episode or a row of episodes. If you do not
    it will download the latest episode existing.

        .PARAMETER From
            The episode number you want to start download

        .PARAMETER To
            The episode number you want to end your downloads
      
        .PARAMETER Path
            Location where files will be downloaded to. Default is MyMusic

        .EXAMPLE
            C:\PS>.\ktra-downloader.ps1 -From 213 -Path "C:\KTRA"
