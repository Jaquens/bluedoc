import i18n from "i18next";

const metaLocale = document.querySelector('meta[name=locale]');
const lang = (metaLocale && metaLocale.content || 'en').replace('-', '_');
i18n.init({
  // we init with resources
  resources: {
    en: {
      locales: {
        "There has count issues": 'There has <span class="text-danger">{{count}}</span> issues:',
        "Repository": "Repository",
        "Search in scope": "Search in {{scope}}",
        "Search BlueDoc": "Search BlueDoc",
        "editor": {
          "Editor": {
            "New Document": "New Document",
            "Write document contents here": "Write document contents here",
            "Paragraph": "Normal",
            "Heading 2": "Heading 2",
            "Heading 3": "Heading 3",
            "Heading 4": "Heading 4",
            "Heading 5": "Heading 5",
            "Heading 6": "Heading 6",
            "Bold": "Bold ⌘-b",
            "Italic": "Italic ⌘-i",
            "Strike Through": "Strike Through",
            "Underline": "Underline ⌘-u",
            "Inline Code": "Inline Code ⌘-`",
            "Bulleted list": "Bulleted list",
            "Numbered list": "Numbered list",
            "Indent": "Indent ⌘-]",
            "Outdent": "Outdent ⌘-[",
            "Align Left": "Align Left",
            "Align Center": "Align Center",
            "Align Right": "Align Right",
            "Align Justify": "Align Justify",
            "Quote": "Quote",
            "Insert Code block": "Insert Code block",
            "Insert PlantUML": "Insert PlantUML",
            "Insert TeX": "Insert TeX",
            "Insert Horizontal line": "Insert Horizontal line",
            "Insert Link": "Insert Link",
            "Insert Image": "Insert Image",
            "Insert File": "Insert File",
            "Insert Video": "Insert Video",
            "Insert Table": "Insert Table",
            "Undo": "Undo",
            "Redo": "Redo",
            "Clear Format": "Clear Format",
          },
          "DocSetting": {
            "Slug": "Doc path",
            "Done": "Done",
          },
        },
        "notes": {
          "EditorSetting": {
            "Note path": "Note path",
            "Description": "Description",
            "Privacy": "Privacy",
            "Public": "Public",
            "Anyone can see this Note": "Anyone can see this Note.",
            "Private": "Private",
            "Only you can see this Note": "Only you can see this Note.",
            "If you change privacy from Public to Private": "If you change privacy from Public to Private, The we will remove the reletion datas (Star, Activity) of this Note.",
            "Done": "Done",
          },
        },
        "toc": {
          "Table of contents": "Table of contents",
          "Add a custom item": "Add a custom item"
        },
        "issues": {
          "Sidebar": {
            "Participants": "participants",
          },
          "Assignees": {
            "Assignee": "Assignee",
            "No one assigned": "No one assigned.",
          },
          "AssigneeMenu": {
            "Filter": "Filter",
            "Clear All": "Clear All",
          },
          "Labels": {
            "Label": "Label",
            "No label": "No label.",
          },
          "LabelMenu": {
            "Filter": "Filter",
            "Clear All": "Clear All",
            "Manage": "Manage...",
          },
          "ListFilter": {
            "Assignee": "Assignee",
            "Label": "Label",
            "Search": "Search",
          }
        },
        "labels": {
          "New Label": "New Label",
          "Label Title": "Title",
          "Edit": "Edit",
          "Update": "Save",
          "Create": "Create",
          "Cancel": "Cancel",
          "Delete": "Delete",
          "Are you sure delete this Label": "Are you sure to delete this Label?",
        }
      },
    },
    zh_CN: {
      locales: {
        "There has count issues": '有 <span class="text-danger">{{count}}</span> 个问题：',
        "Repository": "知识库",
        "Search in scope": "{{scope}}内搜索",
        "Search BlueDoc": "搜索 BlueDoc",
        "editor": {
          "Editor": {
            "New Document": "空白文档",
            "Write document contents here": "在这里开始编写文档正文",
            "Paragraph": "普通文本",
            "Heading 2": "大标题",
            "Heading 3": "副标题",
            "Heading 4": "标题 4",
            "Heading 5": "标题 5",
            "Heading 6": "标题 6",
            "Bold": "加粗 ⌘-b",
            "Italic": "倾斜 ⌘-i",
            "Strike Through": "删除线",
            "Underline": "下划线 ⌘-u",
            "Inline Code": "代码标记 ⌘-`",
            "Bulleted list": "无序列表",
            "Numbered list": "有序列表",
            "Indent": "增加缩进 ⌘-]",
            "Outdent": "减少缩进 ⌘-[",
            "Align Left": "左对齐",
            "Align Center": "居中对齐",
            "Align Right": "右对齐",
            "Align Justify": "两边对齐",
            "Quote": "引用",
            "Insert Code block": "插入代码块",
            "Insert PlantUML": "插入 UML",
            "Insert TeX": "插入数学公式",
            "Insert Horizontal line": "水平分割线",
            "Insert Link": "链接",
            "Insert Image": "插入图片",
            "Insert File": "插入附件",
            "Insert Video": "插入视频",
            "Insert Table": "插入表格",
            "Undo": "撤销",
            "Redo": "重做",
            "Clear Format": "清除格式",
          },
          "DocSetting": {
            "Slug": "文档路径",
            "Done": "更新"
          },
        },
        "notes": {
          "EditorSetting": {
            "Note path": "访问路径",
            "Description": "简介",
            "Privacy": "隐私设置",
            "Public": "公开",
            "Anyone can see this Note": "任何人都可以阅读。",
            "Private": "私密",
            "Only you can see this Note": "只有你可以阅读、管理此笔记。",
            "If you change privacy from Public to Private": "如果将笔记从公开切换到私密模式，其他人对此笔记的收藏记录将会被取消掉。",
            "Done": "更新设置",
          },
        },
        "toc": {
          "Table of contents": "目录",
          "Add a custom item": "添加自定义项"
        },
        "issues": {
          "Sidebar": {
            "Participants": "个参与者",
          },
          "Assignees": {
            "Assignee": "任务指派",
            "No one assigned": "暂无指派处理人。",
          },
          "AssigneeMenu": {
            "Filter": "过滤",
            "Clear All": "清除所有",
          },
          "Labels": {
            "Label": "标签",
            "No label": "暂无标签。",
          },
          "LabelMenu": {
            "Filter": "过滤",
            "Clear All": "清除所有",
            "Manage": "标签管理...",
          },
          "ListFilter": {
            "Assignee": "指派",
            "Label": "标签",
            "Search": "搜索",
          }
        },
        "labels": {
          "New Label": "新建标签",
          "Label Title": "名称",
          "Edit": "编辑",
          "Update": "保存",
          "Create": "创建",
          "Cancel": "取消",
          "Delete": "删除",
          "Are you sure delete this Label": "确定要删除这个标签吗？",
        }
      },
    }
  },
  fallbackLng: "en",
  debug: false,
  lng: lang,

  // have a common namespace used around the full app
  ns: ["locales"],
  defaultNS: "locales",

  react: {
    wait: true
  }
});

export default i18n;

