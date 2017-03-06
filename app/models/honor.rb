class Honor < ApplicationRecord

  serialize :images, Array
  mount_uploaders :images, HonorUploader

  LEVEL = {
    '100': '校赛三等奖',
    '101': '校赛二等奖',
    '102': '省赛三等奖',
    '200': '省赛三等奖',
    '201': '省赛二等奖',
    '202': '省赛一等奖',
    '300': '区域赛优胜奖',
    '301': '区域赛铜奖',
    '302': '区域赛银奖',
    '303': '区域赛金奖'
  }

  # def images=(image_list)
  #   return if image_list.blank?
  #   image_list.each do |image|
  #     filename = "#{self.contest_name}_#{image.original_filename}"
  #     res = Resource.create({
  #       filename: filename,
  #       usage: Resource::USAGE_HONOR,
  #       path: image,
  #       auth: 1
  #     })
  #   end
  # end

end
