access_token = "g8GCI6yCVhh6t6yYYrksJiv56c7QweLxdcipBo28"

get '/' do
  if session[:user_id]
    redirect '/main'
  else
    erb :landing
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(username: params[:username])
  redirect '/login' unless user
  if user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/main'
  else
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/register' do
  erb :register
end

post '/register' do
  user = User.new(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
  if user.save
    session[:user_id] = user.id
    redirect '/main'
  else
    erb :register
  end
end

get '/main' do
  @users = User.all
  @current_user = User.find(session[:user_id])
  erb :main
end

post '/query' do
  @query = params[:query].downcase
  @results = Shipment.where('item LIKE ?', "%#{@query}%")
  content_type :json
  @results.to_json #check functionality on arrays

  #THIS IS THE API CALL
  # url = "https://api.panjiva.com/api/v1/search/supplier?query=#{@query}&access_token=#{access_token}"
  # response = HTTParty.get(url)
end


# response={"credits_remaining"=>5, "num_results"=>15168, "results"=>[{"id"=>27778104, "name"=>"Huzhou Worldbest Tianchang Imp. & Exp. Co., Ltd.", "country"=>"China", "total_shipments"=>813, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>33420305, "name"=>"Shenzhen Lanter Electronics Co. Ltd.", "country"=>"China", "total_shipments"=>8105, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>28256126, "name"=>"Jinan G. Weike Science Technology Co. , Ltd", "country"=>"China", "total_shipments"=>198, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports"], "matched_shipments"=>0}, {"id"=>27782974, "name"=>"Zhejiang Jiashan Yueda Artificial Co., Ltd.", "country"=>"China", "total_shipments"=>166, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27768621, "name"=>"Hebei Cangzhou New Century Foreign Trade Corp.", "country"=>"China", "total_shipments"=>2257, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>28286812, "name"=>"Aarvee Denims And Exports Limited", "country"=>"India", "total_shipments"=>459, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports"], "matched_shipments"=>0}, {"id"=>28039450, "name"=>"Wenzhou Jinzhou Rroup Foreign Trade Industries Co,Ltd", "country"=>"China", "total_shipments"=>1259, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27783257, "name"=>"Zhejiang Jingu Packing & Printing Co., Ltd.", "country"=>"China", "total_shipments"=>274, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27781873, "name"=>"Zhejiang Huangyuan Industry Co,.Ltd", "country"=>"China", "total_shipments"=>263, "data_sources_available"=>["us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>29780636, "name"=>"Zhongshan Yueliang Economy&Trade Imp.&Exp.Co Ltd", "country"=>"China", "total_shipments"=>2965, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports"], "matched_shipments"=>0}, {"id"=>27755965, "name"=>"East Grace Corporation", "country"=>"China", "total_shipments"=>3160, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27765282, "name"=>"Jinhua Runhua Foreign Trade Co., Ltd.", "country"=>"China", "total_shipments"=>575, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27958255, "name"=>"Wenzhou Fangyuan Metal Button Co., Ltd.", "country"=>"China", "total_shipments"=>115, "data_sources_available"=>["colombia_imports", "mexico_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27811175, "name"=>"Zhongshan Jiale Electronic Co., Ltd.", "country"=>"China", "total_shipments"=>112, "data_sources_available"=>["mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27757259, "name"=>"Hangzhou Tianyuan Pet Products Co., Ltd.", "country"=>"China", "total_shipments"=>1355, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27775749, "name"=>"Shandong Dashen Imp. Exp. Co. Ltd.", "country"=>"China", "total_shipments"=>665, "data_sources_available"=>["mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>28403718, "name"=>"Rajby Industries", "country"=>"Pakistan", "total_shipments"=>2399, "data_sources_available"=>["mexico_imports", "us_imports"], "matched_shipments"=>0}, {"id"=>27784818, "name"=>"Ningbo Shuangshui Metal Product Co., Ltd.", "country"=>"China", "total_shipments"=>120, "data_sources_available"=>["colombia_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27757802, "name"=>"Foodchem International Corporation", "country"=>"China", "total_shipments"=>343, "data_sources_available"=>["colombia_imports", "mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}, {"id"=>27786094, "name"=>"Zhejiang Weixing Industrial Development Co Ltd", "country"=>"China", "total_shipments"=>177, "data_sources_available"=>["mexico_imports", "us_imports", "chinese_trade_data"], "matched_shipments"=>0}]}

# response[0]['results'].each { |company | results << company['name'] }



  #open url (HTTParty or cURL or open-URI); returns string; need JSON.parse("string")
  #create an object for these search results (model but not necessarily a database model)
  # create class model for data with attributes with instance variables for what you want to keep in your model
  #iterate through the array of JSON data and create new objects for each element and shovel into array(in lieu of database)

  #pass this array into ERB and on ERB do all factories.each and show the data

