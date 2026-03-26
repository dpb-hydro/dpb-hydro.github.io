for f in home_page_profile.jpg pendulum_stock.jpg treachery.jpg; do
    convert "$f" -resize 800x600^ -gravity Center -extent 800x600 "resized_$f"
done