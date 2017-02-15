module PushService
  class AndroidNotifier
    def notify!(recipients, notification)
      gcm_client.send(recipients, notification)
    end

    private

    def gcm_client
      GCM.new(api_key)
    end

    def api_key
      Rails.application.secrets.google_gcm_key.presence || fail("please define GCM api key")
    end
  end
end
