{ options, config, lib, pkgs, ... }:
with lib;
let
  cfg = config.yomaq.adguardhome;
  inherit (config.networking) hostName;
  inherit (config.yomaq.impermanence) backup;
in
{
  options.yomaq.adguardhome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable custom adGuard Home module
      '';
    };
  };

  config = mkIf cfg.enable {
  environment.persistence."${backup}" = {
    directories = [
      { directory = "/var/lib/AdGuardHome"; user = "adguardhome"; group = "adguardhome"; mode = "u=rwx,g=rx,o="; }
    ];
    services.adguardhome = {
      enable = true;
      allowDHCP = true;
      # settings = { 
        # http = { 
        #   session_ttl = "720h"; 
        # }; 
        # users = [
        #   { name = "carln"; 
        #   }
        # ]; 
        # auth_attempts = 5; 
        # block_auth_min = 15; 
        # http_proxy = ""; 
        # language = ""; 
        # theme = "auto"; 
        # debug_pprof = false; 
        # dns = { 
        #   bind_hosts = [ "0.0.0.0" ]; 
        #   port = 53; 
        #   anonymize_client_ip = false; 
        #   protection_enabled = true; 
        #   blocking_mode = "default"; 
        #   blocking_ipv4 = ""; 
        #   blocking_ipv6 = ""; 
        #   blocked_response_ttl = 10; 
        #   protection_disabled_until = null; 
        #   parental_block_host = "family-block.dns.adguard.com"; 
        #   safebrowsing_block_host = "standard-block.dns.adguard.com"; 
        #   ratelimit = 20; 
        #   ratelimit_whitelist = [ ]; 
        #   refuse_any = true; 
        #   upstream_dns = [ "https://dns10.quad9.net/dns-query" ]; 
        #   upstream_dns_file = ""; 
        #   bootstrap_dns = [ "9.9.9.10" "149.112.112.10" "2620:fe::10" "2620:fe::fe:10" ]; 
        #   all_servers = false; 
        #   fastest_addr = false; 
        #   fastest_timeout = "1s"; 
        #   allowed_clients = [ ]; 
        #   disallowed_clients = [ ]; 
        #   blocked_hosts = [ "version.bind" "id.server" "hostname.bind" ]; 
        #   trusted_proxies = [ "127.0.0.0/8" "::1/128" ]; 
        #   cache_size = 4194304; 
        #   cache_ttl_min = 0; 
        #   cache_ttl_max = 0; 
        #   cache_optimistic = false; 
        #   bogus_nxdomain = [ ]; 
        #   aaaa_disabled = false; 
        #   enable_dnssec = false; 
        #   edns_client_subnet = { 
        #     custom_ip = ""; 
        #     enabled = false; 
        #     use_custom = false; 
        #   }; max_goroutines = 300; 
        #   handle_ddr = true; 
        #   ipset = [ ]; 
        #   ipset_file = ""; 
        #   bootstrap_prefer_ipv6 = false; 
        #   filtering_enabled = true; 
        #   filters_update_interval = 24; 
        #   parental_enabled = false; 
        #   safebrowsing_enabled = false; 
        #   safebrowsing_cache_size = 1048576; 
        #   safesearch_cache_size = 1048576; 
        #   parental_cache_size = 1048576; 
        #   cache_time = 30; 
        #   safe_search = { 
        #     enabled = false; 
        #     bing = true; 
        #     duckduckgo = true; 
        #     google = true; 
        #     pixabay = true; 
        #     yandex = true; 
        #     youtube = true; 
        #   }; 
        #   rewrites = [ ]; 
        #   blocked_services = { 
        #     schedule = { 
        #       time_zone = "Local"; 
        #     }; 
        #     ids = [ ]; 
        #   }; upstream_timeout = "10s"; 
        #   private_networks = [ ]; 
        #   use_private_ptr_resolvers = true; 
        #   local_ptr_upstreams = [ ]; 
        #   use_dns64 = false; 
        #   dns64_prefixes = [ ]; 
        #   serve_http3 = false; 
        #   use_http3_upstreams = false; 
        # }; 
        # tls = { 
        #   enabled = false; 
        #   server_name = ""; 
        #   force_https = false; 
        #   port_https = 443; 
        #   port_dns_over_tls = 853; 
        #   port_dns_over_quic = 853; 
        #   port_dnscrypt = 0; 
        #   dnscrypt_config_file = ""; 
        #   allow_unencrypted_doh = false; 
        #   certificate_chain = ""; 
        #   private_key = ""; 
        #   certificate_path = ""; 
        #   private_key_path = ""; 
        #   strict_sni_check = false; 
        # }; 
        # querylog = { 
        #   ignored = [ ]; 
        #   interval = "2160h"; 
        #   size_memory = 1000; 
        #   enabled = true; 
        #   file_enabled = true; 
        # }; 
        # statistics = { 
        #   ignored = [ ]; 
        #   interval = "24h"; 
        #   enabled = true; 
        # }; 
        # filters = [
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"; 
        #   name = "AdGuard DNS filter"; 
        #   id = 1; 
        #   } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt"; 
        #   name = "AdAway Default Blocklist"; 
        #   id = 2; 
        #   } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_32.txt"; 
        #   name = "The NoTracking blocklist"; 
        #   id = 1702811664; } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_6.txt"; 
        #   name = "Dandelion Sprout's Game Console Adblock List"; i
        #   d = 1702811665; } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_30.txt"; 
        #   name = "Phishing URL Blocklist (PhishTank and OpenPhish)"; 
        #   id = 1702811666; } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_12.txt"; 
        #   name = "Dandelion Sprout's Anti-Malware List"; 
        #   id = 1702811667; } 
        #   { enabled = true; 
        #   url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_23.txt"; 
        #   name = "WindowsSpyBlocker - Hosts spy rules"; 
        #   id = 1702811668; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_34.txt"; name = "HaGeZi Multi NORMAL"; id = 1702811669; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_8.txt"; name = "NoCoin Filter List"; id = 1702811670; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_10.txt"; name = "Scam Blocklist by DurableNapkin"; id = 1702811671; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_42.txt"; name = "ShadowWhisperer's Malware List"; id = 1702811672; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_31.txt"; name = "Stalkerware Indicators List"; id = 1702811673; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"; name = "The Big List of Hacked Malware Web Sites"; id = 1702811674; } { enabled = true; url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"; name = "Malicious URL Blocklist (URLHaus)"; id = 1702811675; }]; whitelist_filters = [ ]; user_rules = [ ]; dhcp = { enabled = false; interface_name = ""; local_domain_name = "lan"; dhcpv4 = { gateway_ip = ""; subnet_mask = ""; range_start = ""; range_end = ""; lease_duration = 86400; icmp_timeout_msec = 1000; options = [ ]; }; dhcpv6 = { range_start = ""; lease_duration = 86400; ra_slaac_only = false; ra_allow_slaac = false; }; }; clients = { runtime_sources = { whois = true; arp = true; rdns = true; dhcp = true; hosts = true; }; persistent = [ ]; }; log = { file = ""; max_backups = 0; max_size = 100; max_age = 3; compress = false; local_time = false; verbose = false; }; os = { group = ""; user = ""; rlimit_nofile = 0; }; schema_version = 24; };
    };
  };
}


