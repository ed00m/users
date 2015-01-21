users_manage 'primaryrolegroup' do
  group_name 'primarygroup'
  group_id 3000
  action [:remove, :create]
  data_bag 'test_group_append'
  append true
end

users_manage 'secondaryrolegroup' do
  group_name 'primarygroup'
  group_id 3000
  action [:remove, :create]
  data_bag 'test_group_append'
  append true
end
