class Curlobj
  def self.body(url)
    c = Curl::Easy.new.tap do |w|
      w.url = url
      w.follow_location = true
      w.timeout = 10
    end
    c.perform
    c.body.to_s
  end

  def self.data_for(url, opts = {})
    perform_and_return_json(prepare(url, opts))
  end

  def self.car2go_data_for(url, opts = {})
    perform_and_return_json(car2go_prepare(url, opts))
  end

  def self.prepare(urlstr, opts = {})
    Curl::Easy.new.tap do |w|
      w.url = urlstr
      w.follow_location = true
      w.timeout = opts[:timeout] || 10
      w.headers["Accept"]           = "application/json;v=1.7"
      w.headers["Proxy-Connection"] = "keep-alive"
      w.headers["Accept-Language"]  = "de-DE,de;q=0.8,en-US;q=0.6,en;q=0.4"
      w.headers["X-Api-Key"]        = ENV['DRIVE_NOW_API_KEY']
      w.headers["User-Agent"]       = "Android App Version 3.12.0"
      w.headers["X-Language"]       = "de"
      w.headers["Accept-Encoding"]  = "gzip, deflate"
      w.headers["Content-Type"]     = "application/json"
      w.headers["Connection"]       = "keep-alive"
    end
  end

  def self.car2go_prepare(urlstr, opts = { })
    Curl::Easy.new.tap do |w|
      w.url = urlstr
      w.follow_location = true
      w.timeout = opts[:timeout] || 10
      w.headers["User-Agent"]       = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36"
      w.headers["Accept-Encoding"]  = "gzip, deflate"
      w.headers["Accept"]           = "application/json;v=1.7"
     end
  end

  def self.perform_and_return_json(c)
    c.perform
    gz = Zlib::GzipReader.new(StringIO.new(c.body.to_s))
    JSON(gz.read)
  end

end
