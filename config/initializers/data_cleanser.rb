ActiveRecord::Base.class_eval do
  def self.cleanse_before_save(*attrs)
    before_save do
      attrs.each do |attr|
        self.send("#{attr}=", self.send(attr).squish) if self.send("#{attr}_changed?")
      end
    end
  end
end