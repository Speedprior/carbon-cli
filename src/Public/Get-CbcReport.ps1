using module ../PSCarbonBlackCloud.Classes.psm1
<#
.DESCRIPTION
This cmdlet returns all reports or specific report from all valid connections.
.LINK  
https://developer.carbonblack.com/reference/carbon-black-cloud/cb-threathunter/latest/feed-api
.SYNOPSIS
This cmdlet returns all reports or specific report from all valid connections.
.PARAMETER FeedId
Id of the Feed
.PARAMETER Feed
CbcFeed object
.PARAMETER Id
Specify the Id of the report to retrieve.
.OUTPUTS
CbcReport[]
.NOTES
Permissions needed: READ org.feeds
.EXAMPLE
PS > Get-CbcReport -FeedId "11a1a1a1-b22b-3333-44cc-dd5555d5d55d"

Returns all reports for specific feed from all connections. 
If you have multiple connections and you want alerts from a specific connection
you can add the `-Server` param.

PS > Get-CbcReport -FeedId "11a1a1a1-b22b-3333-44cc-dd5555d5d55d" -Server $SpecifiedServer
.EXAMPLE
PS > Get-CbcReport -FeedId "11a1a1a1-b22b-3333-44cc-dd5555d5d55d" -Id "11a1a1a1-b22b-3333-44cc-dd5555d5d5fd"

Returns the report with specified Id under feed.
.EXAMPLE
PS > $Feed = Get-CbcFeed -Id "11a1a1a1-b22b-3333-44cc-dd5555d5d55d"
PS > Get-CbcReport -Feed $Feed

Returns all reports for specific feed from all connections.
#>

function Get-CbcReport {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    [OutputType([CbcReport[]])]
    param(
        [Parameter(ParameterSetName = "Default", Position = 0, Mandatory = $true)]
        [string]$FeedId,

        [Parameter(ParameterSetName = "Feed", Position = 0, Mandatory = $true)]
        [CbcFeed]$Feed,

        [Parameter(ParameterSetName = "Default", Position = 1)]
        [Parameter(ParameterSetName = "Feed", Position = 1)]
        [Parameter(ParameterSetName = "Id", Position = 1)]
        [string]$Id,

        [Parameter(ParameterSetName = "Id")]
        [CbcServer[]]$Server
    )

    process {
        if ($Server) {
            $ExecuteServers = $Server
        }
        else {
            $ExecuteServers = $global:DefaultCbcServers
        }
        switch ($PSCmdlet.ParameterSetName) {
            "Default" {
                $ExecuteServers | ForEach-Object {
                    $CurrentServer = $_
                    $Endpoint = $null
                    $Params = ""

                    if ($PSBoundParameters.ContainsKey("Id")) {
                        $Endpoint = $global:CBC_CONFIG.endpoints["Report"]["Details"]
                        $Params = @($FeedId, $Id)
                    }
                    else {
                        $Endpoint = $global:CBC_CONFIG.endpoints["Report"]["Search"]
                        $Params = $FeedId
                    }
        
                    $Response = Invoke-CbcRequest -Endpoint $Endpoint `
                        -Method GET `
                        -Server $_ `
                        -Params $Params `

                    if ($Response.StatusCode -ne 200) {
                        Write-Error -Message $("Cannot get reports(s) for $($_)")
                    }
                    else {
                        $JsonContent = $Response.Content | ConvertFrom-Json
                        if ($PSBoundParameters.ContainsKey("Id")) {
                            return Initialize-CbcReport $JsonContent.report $CurrentServer
                        }
                        else {
                            $JsonContent.results | ForEach-Object {
                                return Initialize-CbcReport $_ $CurrentServer
                            }
                        }
                    }
                }
            }
            "Feed" {
                $Endpoint = $null
                $Params = ""
                
                if ($PSBoundParameters.ContainsKey("Id")) {
                    $Endpoint = $global:CBC_CONFIG.endpoints["Report"]["Details"]
                    $Params = @($Feed.Id, $Id)
                }
                else {
                    $Endpoint = $global:CBC_CONFIG.endpoints["Report"]["Search"]
                    $Params = $Feed.Id
                }
    
                $Response = Invoke-CbcRequest -Endpoint $Endpoint `
                    -Method GET `
                    -Server $Feed.Server `
                    -Params $Params `

                if ($Response.StatusCode -ne 200) {
                    Write-Error -Message $("Cannot get reports(s) for $($Feed.Server)")
                }
                else {
                    $JsonContent = $Response.Content | ConvertFrom-Json
                    if ($PSBoundParameters.ContainsKey("Id")) {
                        return Initialize-CbcReport $JsonContent.report $Feed.Server
                    }
                    else {
                        $JsonContent.results | ForEach-Object {
                            return Initialize-CbcReport $_ $Feed.Server
                        }
                    }
                }
            }
        }
    }
}