get '/images/cleanliness/4/:value.svg' do
  generate_svg "cleanliness4" do
    @clrs = case params[:value]
            when "1" then ["ea1f24", "ffffff", "ffffff","ffffff"]
            when "2" then ["ea1f24", "cb920a", "ffffff","ffffff"]
            when "3" then ["ea1f24", "cb920a", "c6ea1f","ffffff"]
            when "4" then ["ea1f24", "cb920a", "c6ea1f","13fd0d"]
            else
              ["ffffff", "ffffff", "ffffff","ffffff"]
            end
  end
end

get '/images/cleanliness/2/:value.svg' do
  generate_svg "cleanliness2" do
    @clrs = case params[:value]
            when "1" then ["ea1f24", "ffffff"]
            when "2" then ["ea1f24", "13fd0d"]
            else
              ["ffffff", "ffffff"]
            end
  end
end

get '/images/car/drivenow/:type.svg' do
  generate_svg "drive_now_car" do
    @fillclr = params[:type] == "electro" ? "86b80e" : "005c7d"
  end
end

get '/images/station/mc/:type/:status.svg' do
  @bgclr = "bf0f7b"
  if params[:type] == "petrol"
    generate_svg("mc_petrolstation")
  else
    @handclr = params[:status] == "crowded" ? "999" : "4b994f"
    generate_svg("mc_electrostation")
  end
end