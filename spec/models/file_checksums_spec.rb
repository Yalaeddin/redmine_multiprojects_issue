require "spec_helper"

describe "FileChecksums" do

  def assert_checksum(expected, filename)
    filepath = Rails.root.join(filename)
    checksum = Digest::MD5.hexdigest(File.read(filepath))
    assert checksum.in?(Array(expected)), "Bad checksum for file: #{filename}, local version should be reviewed: checksum=#{checksum}, expected=#{Array(expected).join(" or ")}"
  end

  it "should core issue model checksum" do
    # "notified_users", "visible_condition" and "visible?" methods are overridden
    # and should be reviewed if this test breaks
    # 4.2.7 is ok
    assert_checksum %w(a1f8ffdc9ec1124468d45780731a94a9), "app/models/issue.rb"
  end

  # tests have been added to the issue_helper_patch_test file, no need to check the checksum
  #def test_core_issues_helper_checksum
  # "show_detail" method is overridden
  # assert_checksum %w(9ef285e8ecc7986993cd31d8bd84b156), "app/helpers/issues_helper.rb"
  #end

  it "should core query model checksum" do
    # "project_statement" method is overridden
    # and should be reviewed if this test breaks
    # 4.2.7 is ok
    assert_checksum %w(11741752fee9e227a6c5af19acb8a56e), "app/models/query.rb"
  end

  it "should core issue query model checksum" do
    # "versions" method is overridden
    # and should be reviewed if this test breaks
    # 4.2.7 is ok
    assert_checksum %w(c813cc6b3ac6328e3d21fa86b328bbd5), "app/models/issue_query.rb"
  end

  it "should core edit and new form js checksum" do
    # "new.js.erb" and "edit.js.erb" are completely overridden
    # and should be reviewed if these tests breaks
    # 4.2 is ok
    assert_checksum %w(1fd7f7770d15713675b475d07dd2d364), "app/views/issues/new.js.erb"
    assert_checksum %w(0a92d0609b883d43daf5e825bc08cb01), "app/views/issues/edit.js.erb"
  end

  it "should check acts_as_activity_provider" do
    # "acts_as_activity_provider.rb" is completely overridden
    # and should be reviewed if these tests breaks
    # 4.2 is ok
    assert_checksum %w(9c376fe7d1cd774107abd1b9eaf37c6e), "lib/plugins/acts_as_activity_provider/lib/acts_as_activity_provider.rb"
  end

  it "checks issue_custom_field model changes" do
    # "visibility_by_project_condition" method is completely overridden, for performance reasons
    # and should be reviewed if these tests breaks
    # 4.2.7 is ok
    assert_checksum %w(fd88168b29f2b3718c3e885c5c55b757), "app/models/issue_custom_field.rb"
  end

end
