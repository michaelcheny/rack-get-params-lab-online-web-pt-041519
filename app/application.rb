# Instructions
# Create a new class array called @@cart to hold any items in your cart
# Create a new route called /cart to show the items in your cart
# Create a new route called /add that takes in a GET param with the key item. This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end

    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else 
        @@cart.each{|item| resp.write "#{item}\n"}
      end

    elsif req.path.match(/add/)
      add_this = req.params["item"]
      if @@items.include?(add_this)
        @@cart << add_this
        resp.write "added #{add_this}"
      else
        resp.write "We don't have that item"
      end

    else
      resp.write "Path Not Found"
    end



    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
