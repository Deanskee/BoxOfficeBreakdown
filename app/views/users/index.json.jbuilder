json.users do |json|
 json.array! @users do |u|
  json.extract! u, :id, :name
   json.guesses do |json|
   	 json.array! u.guesses do |g|
      json.extract! g, :id, :amount
      end
	end
	json.groups do |json|
   	 json.array! u.groups do |g|
      json.extract! g, :id, :name, :description
      end
	end
  end
end