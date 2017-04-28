
# 概述

NSOperation 默认是非并发，也就是说所有的动态量由系统内部控制，在你的main方法结束也就意味着operation的结束；这样的话我们会经常有这样的需求，最常见的图片下载，需要通过NSOperation来实现，如果在main方法开启异步下载的话，那么main方法返回后就代表operation的结束，你的下载相关委托可能不会回调或者回调之前operation已经finished；所以我们来设计一个我们自己可控的并发的operation。
要想实现可控的并发的operation，那么我们就首先告诉系统，此operation需要并发，那么首先重写

详细说明移步[简书](http://www.jianshu.com/p/90b41ecbb4cf)


