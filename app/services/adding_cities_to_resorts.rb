class AddingCitiesToResorts

  def initialize
    for i in (1..Resort.count) do
      r = Resort.find(i)
      if r['url']
        i_url = r['url'].split("_").length - 2
        r['ville_url']=r['url'].split("_")[i_url]
        r['ville']=URI.unescape(r['url'].split("_")[i_url])
        r.save
      end
    end
  end
end