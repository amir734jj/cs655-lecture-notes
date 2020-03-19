---
marp: true
---
# Title!

  def obj_header(label : String, cn : String, tag : Int, size : Int) : Unit = {
    data();
    word(-1);
    label_def(label);
    word(tag);
    word(size+i_ATTROFFSET());
    word(cn.concat(s_DISPTAB()));
    ()
  };
