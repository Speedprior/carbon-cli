function Initialize-CbcWatchlist {
    param(
        [Parameter(Mandatory = $true,Position = 0)]
		[ValidateNotNullOrEmpty()]
		[PSCustomObject]$Response,

        [Parameter(Mandatory = $true,Position = 1)]
		[ValidateNotNullOrEmpty()]
		[CbcServer]$Server
	)
    [CbcWatchlist]::new(
        $Response.id,
        $Response.name,
        $Response.description,
        $Response.alerts_enabled,
        $Response.tags_enabled,
        $Response.alert_classification_enabled,
        $Server
    )
}
