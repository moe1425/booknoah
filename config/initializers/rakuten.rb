RakutenWebService.configure do |c|
    # (必須) アプリケーションID
    c.application_id = ENV['APPLICATION_ID']
    
    # (任意) 楽天アフィリエイトID
    c.affiliate_id = ENV['AFFILIATE_ID']
end