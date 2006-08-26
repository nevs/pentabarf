require File.dirname(__FILE__) + '/../test_helper'
require '../../app/helpers/application_helper'

class MarkupTest < Test::Unit::TestCase
  include ApplicationHelper

  def h s; s; end

  def test_paragraphs
    assert_equal("", markup("").gsub(/\n/, ''))
    assert_equal("<p>a</p>", markup("a").gsub(/\n/, ''))
    10.times do |n|
      n += 1
      assert_equal("<p>a\n</p>\n" * n, markup("a\n\n" * n))
    end
  end

  def test_headlines
    (1..6).each { |n|
      assert_equal("<h#{n}>abc</h#{n}>", markup(("=" * n) + "abc" + ("=" * n)).gsub(/\n/, ''))
    }
  end

  def test_bold
    assert_equal("<p><b>Test</b></p>", markup("**Test**").gsub(/\n/, ''))
  end

  def test_italic
    assert_equal("<p><i>Test</i></p>", markup("//Test//").gsub(/\n/, ''))
  end

  def test_bold
    assert_equal("<p><u>Test</u></p>", markup("__Test__").gsub(/\n/, ''))
  end

  def test_blockquote
    assert_equal("<dd>abc</dd>", markup(":abc").gsub(/\n/, ''))
    assert_equal("<dd>abc</dd><dd>xyz</dd>", markup(":abc\n:xyz").gsub(/\n/, ''))
  end

  def test_unordered_lists
    assert_equal("<ul><li>a</li><li>b</li><li>c</li></ul>", markup("*a\n*b\n*c\n").gsub(/\n/, ''))
  end

  def test_ordered_lists
    assert_equal("<ol><li>a</li><li>b</li><li>c</li></ol>", markup("#a\n#b\n#c\n").gsub(/\n/, ''))
  end

  def test_nested_lists
    assert_equal("<ul><li>Numbers:</li><li><ol><li>1</li><li>2</li><li>3</li></ol></li></ul>", markup("*Numbers:\n*#1\n*#2\n*#3").gsub(/\n/, ''))
    assert_equal("<ul><li>Letters:</li><li><ul><li>a</li><li>b</li><li>c</li></ul></li></ul>", markup("*Letters:\n**a\n**b\n**c").gsub(/\n/, ''))
  end
end
