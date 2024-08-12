_: {
  programs.aria2 = {
    enable = true;
    settings = {
      file-allocation = "none";
      log-level = "warn";
      max-connection-per-server = 16;
      min-split-size = "1M";
      remote-time = true;
      allow-piece-length-change = true;
      parameterized-uri = true;
      optimize-concurrent-downloads = true;
      deferred-input = true;
      continue = true;
      check-integrity = true;
      realtime-chunk-checksum = true;
      piece-length = "1M";
      split = 16;
      save-session-interval = 60;
      disk-cache = "32M";
      save-not-found = true;
      download-result = "full";
      truncate-console-readout = true;
      retry-wait = 30;
      max-tries = 15;
      enable-color = true;
      enable-http-keep-alive = true;
      enable-http-pipelining = true;
      http-accept-gzip = true;
      bt-save-metadata = true;
      seed-time = 0;
      bt-load-saved-metadata = true;
      metalink-preferred-protocol = "https";
    };
  };
}
