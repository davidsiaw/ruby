require_relative '../../spec_helper'

describe "Module#private_constant" do
  it "can only be passed constant names defined in the target (self) module" do
    cls1 = Class.new
    cls1.const_set :Foo, true
    cls2 = Class.new(cls1)

    -> do
      cls2.send :private_constant, :Foo
    end.should raise_error(NameError)
  end

  it "accepts strings as constant names" do
    cls = Class.new
    cls.const_set :Foo, true
    cls.send :private_constant, "Foo"

    -> { cls::Foo }.should raise_error(NameError)
  end

  it "accepts multiple names" do
    mod = Module.new
    mod.const_set :Foo, true
    mod.const_set :Bar, true

    mod.send :private_constant, :Foo, :Bar

    -> {mod::Foo}.should raise_error(NameError)
    -> {mod::Bar}.should raise_error(NameError)
  end
end
