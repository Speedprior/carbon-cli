Describe "Get-CBCDevice" {   
    
    BeforeEach {
        $CBC_CONFIG.currentConnections = [System.Collections.ArrayList]@()
    }

    InModuleScope PSCarbonBlackCloud {

        BeforeAll {

            $TestServerObject1 = [PSCustomObject]@{
                PSTypeName = "CBCServer"
                Uri = "https://test.adasdagf/"
                Org = "test"
                Token = "test"
            }

            $TestServerObject2 = [PSCustomObject]@{
                PSTypeName = "CBCServer"
                Uri = "https://test02.adasdagf/"
                Org = "test2"
                Token = "test"
            }

            $MutlipleResultsResponse = @"
            {
                "results": [
                  {
                      "activation_code": null,
                      "activation_code_expiry_time": "2022-07-11T06:53:06.190Z",
                      "ad_group_id": 0,
                      "appliance_name": null,
                      "appliance_uuid": null,
                      "auto_scaling_group_name": null,
                      "av_ave_version": "8.3.64.172",
                      "av_engine": "4.15.1.560-ave.8.3.64.172:avpack.8.5.2.64:vdf.8.19.20.4:vdfdate.20220711",
                      "av_last_scan_time": null,
                      "av_master": false,
                      "av_pack_version": "8.5.2.64",
                      "av_product_version": "4.15.1.560",
                      "av_status": [
                          "AV_ACTIVE",
                          "ONDEMAND_SCAN_DISABLED"
                      ],
                      "av_update_servers": null,
                      "av_vdf_version": "8.19.20.4",
                      "base_device": null,
                      "cloud_provider_account_id": null,
                      "cloud_provider_resource_id": null,
                      "cloud_provider_tags": null,
                      "cluster_name": null,
                      "current_sensor_policy_name": "CB-policy",
                      "datacenter_name": null,
                      "deployment_type": "ENDPOINT",
                      "deregistered_time": null,
                      "device_meta_data_item_list": [
                          {
                              "key_name": "OS_MAJOR_VERSION",
                              "key_value": "Windows 10",
                              "position": 0
                          },
                          {
                              "key_name": "SUBNET",
                              "key_value": "198.18.127",
                              "position": 0
                          }
                      ],
                      "device_owner_id": 854220,
                      "email": "vagrant",
                      "esx_host_name": null,
                      "esx_host_uuid": null,
                      "first_name": null,
                      "golden_device": null,
                      "golden_device_id": null,
                      "host_based_firewall_failure_reason": null,
                      "host_based_firewall_status": null,
                      "id": 5765374,
                      "last_contact_time": "2022-07-11T22:04:42.993Z",
                      "last_device_policy_changed_time": "2022-07-04T13:22:15.870Z",
                      "last_device_policy_requested_time": "2022-07-04T13:46:25.278Z",
                      "last_external_ip_address": "162.111.555.333",
                      "last_internal_ip_address": "198.18.127.111",
                      "last_location": "OFFSITE",
                      "last_name": null,
                      "last_policy_updated_time": "2022-05-18T09:33:54.616Z",
                      "last_reported_time": "2022-07-11T22:04:43.063Z",
                      "last_reset_time": null,
                      "last_shutdown_time": "2022-07-04T06:58:55.867Z",
                      "linux_kernel_version": null,
                      "login_user_name": "CARBONBLACK\\testuser",
                      "mac_address": "fa163e92d344",
                      "middle_name": null,
                      "name": "carbonblack",
                      "nsx_distributed_firewall_policy": null,
                      "nsx_enabled": null,
                      "organization_id": 1105,
                      "organization_name": "cb-internal-alliances.com",
                      "os": "WINDOWS",
                      "os_version": "Windows 10 x64",
                      "passive_mode": false,
                      "policy_id": 87816,
                      "policy_name": "CB-policy",
                      "policy_override": true,
                      "quarantined": false,
                      "registered_time": "2022-07-04T06:53:06.220Z",
                      "scan_last_action_time": null,
                      "scan_last_complete_time": null,
                      "scan_status": null,
                      "sensor_kit_type": "WINDOWS",
                      "sensor_out_of_date": false,
                      "sensor_pending_update": false,
                      "sensor_states": [
                          "ACTIVE",
                          "LIVE_RESPONSE_NOT_RUNNING",
                          "LIVE_RESPONSE_NOT_KILLED",
                          "LIVE_RESPONSE_ENABLED"
                      ],
                      "sensor_version": "3.8.0.627",
                      "status": "REGISTERED",
                      "target_priority": "MEDIUM",
                      "uninstall_code": "R6VERVN2",
                      "vcenter_host_url": null,
                      "vcenter_name": null,
                      "vcenter_uuid": null,
                      "vdi_base_device": null,
                      "virtual_machine": false,
                      "virtual_private_cloud_id": null,
                      "virtualization_provider": "OTHER",
                      "vm_ip": null,
                      "vm_name": null,
                      "vm_uuid": null,
                      "vulnerability_score": 0.0,
                      "vulnerability_severity": null,
                      "windows_platform": null
                  },
                  {
                    "activation_code": null,
                    "activation_code_expiry_time": "2022-07-11T06:53:06.190Z",
                    "ad_group_id": 0,
                    "appliance_name": null,
                    "appliance_uuid": null,
                    "auto_scaling_group_name": null,
                    "av_ave_version": "8.3.64.172",
                    "av_engine": "4.15.1.560-ave.8.3.64.172:avpack.8.5.2.64:vdf.8.19.20.4:vdfdate.20220711",
                    "av_last_scan_time": null,
                    "av_master": false,
                    "av_pack_version": "8.5.2.64",
                    "av_product_version": "4.15.1.560",
                    "av_status": [
                        "AV_ACTIVE",
                        "ONDEMAND_SCAN_DISABLED"
                    ],
                    "av_update_servers": null,
                    "av_vdf_version": "8.19.20.4",
                    "base_device": null,
                    "cloud_provider_account_id": null,
                    "cloud_provider_resource_id": null,
                    "cloud_provider_tags": null,
                    "cluster_name": null,
                    "current_sensor_policy_name": "CB-policy",
                    "datacenter_name": null,
                    "deployment_type": "ENDPOINT",
                    "deregistered_time": null,
                    "device_meta_data_item_list": [
                        {
                            "key_name": "OS_MAJOR_VERSION",
                            "key_value": "Windows 10",
                            "position": 0
                        },
                        {
                            "key_name": "SUBNET",
                            "key_value": "198.18.127",
                            "position": 0
                        }
                    ],
                    "device_owner_id": 854220,
                    "email": "vagrant",
                    "esx_host_name": null,
                    "esx_host_uuid": null,
                    "first_name": null,
                    "golden_device": null,
                    "golden_device_id": null,
                    "host_based_firewall_failure_reason": null,
                    "host_based_firewall_status": null,
                    "id": 5765373,
                    "last_contact_time": "2022-07-11T22:04:42.993Z",
                    "last_device_policy_changed_time": "2022-07-04T13:22:15.870Z",
                    "last_device_policy_requested_time": "2022-07-04T13:46:25.278Z",
                    "last_external_ip_address": "162.111.555.333",
                    "last_internal_ip_address": "198.18.127.111",
                    "last_location": "OFFSITE",
                    "last_name": null,
                    "last_policy_updated_time": "2022-05-18T09:33:54.616Z",
                    "last_reported_time": "2022-07-11T22:04:43.063Z",
                    "last_reset_time": null,
                    "last_shutdown_time": "2022-07-04T06:58:55.867Z",
                    "linux_kernel_version": null,
                    "login_user_name": "CARBONBLACK\\testuser",
                    "mac_address": "fa163e92d344",
                    "middle_name": null,
                    "name": "carbonblack",
                    "nsx_distributed_firewall_policy": null,
                    "nsx_enabled": null,
                    "organization_id": 1105,
                    "organization_name": "cb-internal-alliances.com",
                    "os": "WINDOWS",
                    "os_version": "Windows 10 x64",
                    "passive_mode": false,
                    "policy_id": 87816,
                    "policy_name": "CB-policy",
                    "policy_override": true,
                    "quarantined": false,
                    "registered_time": "2022-07-04T06:53:06.220Z",
                    "scan_last_action_time": null,
                    "scan_last_complete_time": null,
                    "scan_status": null,
                    "sensor_kit_type": "WINDOWS",
                    "sensor_out_of_date": false,
                    "sensor_pending_update": false,
                    "sensor_states": [
                        "ACTIVE",
                        "LIVE_RESPONSE_NOT_RUNNING",
                        "LIVE_RESPONSE_NOT_KILLED",
                        "LIVE_RESPONSE_ENABLED"
                    ],
                    "sensor_version": "3.8.0.627",
                    "status": "REGISTERED",
                    "target_priority": "MEDIUM",
                    "uninstall_code": "R6VERVN2",
                    "vcenter_host_url": null,
                    "vcenter_name": null,
                    "vcenter_uuid": null,
                    "vdi_base_device": null,
                    "virtual_machine": false,
                    "virtual_private_cloud_id": null,
                    "virtualization_provider": "OTHER",
                    "vm_ip": null,
                    "vm_name": null,
                    "vm_uuid": null,
                    "vulnerability_score": 0.0,
                    "vulnerability_severity": null,
                    "windows_platform": null
                }
                ],
                "num_found": 2
            }
"@

        }

        Context "When in All Section" {

            It "Should return one result" {
                
                $CBC_CONFIG.currentConnections.Add($TestServerObject1) | Out-Null
            
                Mock Invoke-CBCRequest -MockWith {
                    return @{
                        StatusCode = 200
                        Content = $MutlipleResultsResponse
                    }
                } -ParameterFilter { 
                    $Server -match $TestServerObject1
                    $Endpoint -eq $CBC_CONFIG.endpoints["Devices"]["Search"]
                    $Method -eq "POST"
                }

                $Results = Get-CBCDevice -All
                $Results.Count | Should -Be 2

            }

            It "Should return multiple result" {
                
                $CBC_CONFIG.currentConnections.Add($TestServerObject1) | Out-Null
                $CBC_CONFIG.currentConnections.Add($TestServerObject2) | Out-Null
            
                Mock Invoke-CBCRequest -MockWith {
                    return @{
                        StatusCode = 200
                        Content = $MutlipleResultsResponse
                    }
                } -ParameterFilter { 
                    $Server -match $TestServerObject1
                    $Endpoint -eq $CBC_CONFIG.endpoints["Devices"]["Search"]
                    $Method -eq "POST"
                }

                Mock Invoke-CBCRequest -MockWith {
                    return @{
                        StatusCode = 200
                        Content = $MutlipleResultsResponse
                    }
                } -ParameterFilter { 
                    $Server -match $TestServerObject2
                    $Endpoint -eq $CBC_CONFIG.endpoints["Devices"]["Search"]
                    $Method -eq "POST"
                }

                $Results = Get-CBCDevice -All
                $Results.Count | Should -Be 4

            }

        }
        
    }

}