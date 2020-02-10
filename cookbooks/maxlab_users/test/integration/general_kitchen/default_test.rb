# InSpec test for recipe maxlab_users::general_kitchen

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe group('maxwell') do
  it { should exist }
end

describe user('maxwell') do
  it { should exist }
end
