<#
.SYNOPSIS
    .
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
    C:\PS> 
    .\ktra-downloader.ps1 -From 213 -Path "C:\KTRA"
.NOTES
    Author: Andreas Kestler
    Date:   May 02, 2018    
#>
param(
    [int]$From,
    [int]$To,
    [string]$Path = [Environment]::GetFolderPath("MyMusic")
)

#check newest episode if From/to empty

#If $From is empty, grab lastest episode
if(!$From) { 
    #Getting latest episode number
    $web = Invoke-Webrequest https://www.keepingtheravealive.com/podcast/
    $newestepisode_temp = $web.tostring() -split "[`r`n]" | select-string "episode-" | Select-Object -First 1
    $newestepisode_temp = $newestepisode_temp -split '.*episode\-'
    $newestepisode_temp = $newestepisode_temp[1] -split '\".*$'
    [int]$newestepisode = $newestepisode_temp[0].Trim()
    $From = $newestepisode
}
if(!$To) {
    $To = $From
}
if($From -and !$To) {
    Write-Output "Only To-Parameter is not a valid option."
}

if(!(Test-Path $Path)) {
    Write-Output "$Path doesn't exist. Please provide an existing folder."
    exit
}

do {

$url = "http://www.djkutski.com/podcast/keepingtheravealive$From.mp3"
$output = "$Path\keepingtheravealive$From.mp3"
if((Test-Path $output)) {
    Write-Output "Skipping episode $From, already existing"
}
else
{
    $start_time = Get-Date

    $wc = New-Object System.Net.WebClient
    Write-Output "Download of episode $From in  progress.."
    $wc.DownloadFile($url, $output)
    Write-Output "Episode $From finished in $((Get-Date).Subtract($start_time).Seconds) second(s)"
}
$From = $From+1

} while($From -le $To)