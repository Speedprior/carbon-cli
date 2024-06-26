using module ..\..\CarbonCLI\CarbonCLI.Classes.psm1

BeforeAll {
    $ProjectRoot = (Resolve-Path "$PSScriptRoot/../..").Path
    Remove-Module -Name CarbonCLI -ErrorAction 'SilentlyContinue' -Force
    Import-Module $ProjectRoot\CarbonCLI\CarbonCLI.psm1 -Force
}

AfterAll {
    Remove-Module -Name CarbonCLI -Force
}

Describe "Remove-CbcWatchlist" {
    Context "When using the 'default' parameter set" {
        Context "When using one connection" {
            BeforeAll {
                $Uri1 = "https://t.te1/"
                $Org1 = "test1"
                $secureToken1 = "test1" | ConvertTo-SecureString -AsPlainText
                
			    $s1 = [CbcServer]::new($Uri1, $Org1, $secureToken1)
                $global:DefaultCbcServers = [System.Collections.ArrayList]@()
                $global:DefaultCbcServers.Add($s1) | Out-Null
            }

            It "Should remove watchlist" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    if ($Server -eq $s1) {
                        @{
                            StatusCode = 204
                        }
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE" -and
                    ($Server -eq $s1)
                }
                { Remove-CbcWatchlist -Id ABCDEFGHIJKLMNOPQRSTUVWX -ErrorAction Stop } | Should -Not -Throw
            }
        }

        Context "When using multiple connections" {
            BeforeAll {
                $Uri1 = "https://t.te1/"
                $Org1 = "test1"
                $secureToken1 = "test1" | ConvertTo-SecureString -AsPlainText
                $Uri2 = "https://t.te2/"
                $Org2 = "test2"
                $secureToken2 = "test2" | ConvertTo-SecureString -AsPlainText
                $s1 = [CbcServer]::new($Uri1, $Org1, $secureToken1)
                $s2 = [CbcServer]::new($Uri2, $Org2, $secureToken2)
                $global:DefaultCbcServers = [System.Collections.ArrayList]@()
                $global:DefaultCbcServers.Add($s1) | Out-Null
                $global:DefaultCbcServers.Add($s2) | Out-Null
                $watchlist = [CbcWatchlist]::new(
                    "ABCDEFGHIJKLMNOPQRSTUVWX",
                    "My Watchlist",
                    "Example Watchlist",
                    $true,
                    $true,
                    $true,
                    "ABCDEFGHIJKLMNOPQRSTUVWX",
                    $s1
                )
            }

            It "Should delete watchlist for specific connections" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    if ($Server -eq $s1) {
                        @{
                            StatusCode = 204
                        }
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE" -and
                    ($Server -eq $s1)
                }
                { Remove-CbcWatchlist -Id ABCDEFGHIJKLMNOPQRSTUVWX -Server $s1 -ErrorAction Stop } | Should -Not -Throw
            }

            It "Should delete watchlist for all connections" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    @{
                        StatusCode = 204
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE"
                }
                { Remove-CbcWatchlist -Id ABCDEFGHIJKLMNOPQRSTUVWX -ErrorAction Stop } | Should -Not -Throw
            }

            It "Should try to delete watchlist for all connections - exception" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    @{
                        StatusCode = 500
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE"
                }
                { Remove-CbcWatchlist -Id ABCDEFGHIJKLMNOPQRSTUVWX -ErrorAction Stop } | Should -Throw
            }

            It "Should delete watchlist - CbcWatchlist" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    @{
                        StatusCode = 204
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE" -and
                    ($Server -eq $s1)
                }
                { Remove-CbcWatchlist -Watchlist $watchlist -ErrorAction Stop } | Should -Not -Throw
            }

            It "Should delete watchlist CbcWatchlist - exception" {
                Mock Invoke-CbcRequest -ModuleName CarbonCLI {
                    @{
                        StatusCode = 500
                    }
                } -ParameterFilter {
                    $Endpoint -eq $global:CBC_CONFIG.endpoints["Watchlist"]["Details"] -and
                    $Method -eq "DELETE" -and
                    ($Server -eq $s1)
                }
                { Remove-CbcWatchlist -Watchlist $watchlist -ErrorAction Stop } | Should -Throw
            }
        }
    }
}
