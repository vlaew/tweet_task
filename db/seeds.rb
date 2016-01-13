# Users
[
  'John Doe',
  'Jane Doe',
  'John Smith',
  'Lee Harvey',
  'Oscar Davids',
  'Hovard Blum',
  'Tiffany Austin',
  'Miranda Weendblu',
  'Gregory Maastach',
  'Ivan Fedorov'
].each do |user_name|
  User.create(name: user_name)
end

users = User.all.to_a
dates_range = (1.month.ago(Time.zone.today)..Time.zone.today).to_a

# Tweets
[
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  'Nullam gravida magna ut viverra ornare.',
  'Donec dignissim ex vitae fringilla elementum.',
  'Nam vehicula risus non felis viverra tincidunt.',
  'Aliquam lobortis lacus nec tempor elementum.',
  'Proin ullamcorper augue at ante malesuada, sit amet rhoncus ex pellentesque.',
  'Aliquam malesuada est porta pellentesque auctor.',
  'Donec tincidunt tortor quis dictum feugiat.',
  'Ut sed justo lacinia, scelerisque massa et, egestas elit.',
  'Mauris ut tortor scelerisque erat dignissim blandit.',
  'Morbi varius libero non sem fringilla, pharetra fermentum leo venenatis.',
  'Vestibulum hendrerit eros nec nisl commodo mollis.',
  'Donec fringilla neque ac iaculis congue.',
  'Quisque at justo aliquet enim viverra vehicula.',
  'Ut eget tortor eget enim volutpat bibendum.',
  'Donec vitae orci dictum, blandit dui ac, finibus elit.',
  'Sed egestas leo vel sem cursus, accumsan lacinia nisi iaculis.',
  'Fusce at mauris varius, malesuada nisi sed, imperdiet mi.',
  'Nunc quis urna at justo dapibus efficitur.',
  'Praesent nec libero et erat faucibus tristique.',
  'Praesent suscipit velit id vulputate rutrum.',
  'Phasellus lacinia turpis et justo sodales placerat.',
  'Quisque convallis dui vel mauris condimentum rhoncus.',
  'Cras at ipsum at est tincidunt maximus eu vitae sapien.',
  'Phasellus id nisi et nibh laoreet scelerisque.',
  'Nulla eu eros non velit eleifend facilisis eu at nisi.',
  'Nam tristique dui at tempus pellentesque.',
  'Pellentesque pulvinar felis nec efficitur feugiat.',
  'In tempor elit eu tellus placerat, vitae accumsan elit maximus.',
  'Sed suscipit libero et sem aliquet, non dictum lacus malesuada.',
  'Suspendisse nec lorem sodales, commodo libero non, volutpat leo.',
  'Sed suscipit ligula quis ultrices tristique.',
  'Sed maximus arcu a erat rutrum scelerisque.',
  'Aliquam faucibus purus ut quam mollis, ac fermentum nulla tincidunt.',
  'Sed semper magna eu elit sodales imperdiet.',
  'Vivamus nec ligula aliquam, vulputate diam eu, pharetra neque.',
  'Praesent malesuada ante et viverra hendrerit.'
].each do |text|
  Tweet.create(user: users.sample, text: text, created_at: dates_range.sample)
end

# Votes
Tweet.all.each do |tweet|
  users.shuffle.take(rand(users.size)).each do |user|
    Vote.create(user: user, tweet: tweet)
  end
end
