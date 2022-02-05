# # encoding: utf-8

# Inspec test for recipe maxlab_base::deploy-bare-metal

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# ADDTIONAL PACKAGE DEPLOYED BY deploy-bare-metal.rb recipe

describe package('lm_sensors') do
  it { should be_installed }
end
