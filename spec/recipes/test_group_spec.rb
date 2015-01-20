require 'spec_helper'

describe 'users_test::test_group_append' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: ['users_manage']) do |node, server|
      server.create_data_bag('test_group_append', {
        user_in_primary_role_group: {
          id: 'user_in_primary_role_group',
          groups: ['primarygroup', 'primaryrolegroup']
        },
        user_in_secondary_role_group: {
          id: 'user_in_secondary_role_group',
          groups: ['primarygroup', 'secondaryrolegroup'],
        }
      })
    end.converge(described_recipe)
  end

  context 'Resource "users_manage"' do
    it 'creates users' do
      expect(chef_run).to create_user('user_in_primary_role_group')
      expect(chef_run).to create_user('user_in_secondary_role_group')
    end

    it 'manages .ssh dir for users' do
      expect(chef_run).to create_directory('/home/user_in_primary_role_group/.ssh')
      expect(chef_run).to create_directory('/home/user_in_secondary_role_group/.ssh')
    end

    it 'creates groups' do
      expect(chef_run).to create_group('primarygroup')
      expect(chef_run).to_not create_group('primaryrolegroup')
      expect(chef_run).to_not create_group('secondaryrolegroup')
    end

    it 'manages groups' do
      expect(chef_run).to create_users_manage('primaryrolegroup')
      expect(chef_run).to create_users_manage('secondaryrolegroup')
    end
  end
end
