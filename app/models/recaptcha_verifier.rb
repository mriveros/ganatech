class RecaptchaVerifier
  def initialize(response, ip)
    @response = response
    @ip = ip
  end

  def self.verify(response, ip = nil)
    new(response, ip).verify
  end

  def verify
    recaptcha_response = HTTParty.get(recaptcha_url(@response, secret, @ip))
    response_success?(recaptcha_response)
  end

  private
  def recaptcha_url(response, secret, ip)
    "https://www.google.com/recaptcha/api/siteverify?secret=#{secret}&response=#{response}&remoteip=#{ip}"
  end

  def secret
    # load your secret here or hardcode it
    "6Lc-0PcSAAAAANs5JkrSwG5JEtw5BhEiv4OfnEYL"
  end

  def response_success?(response)
    response.fetch('success')
  end
end
