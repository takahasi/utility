#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/fs.h>
#include <asm/uaccess.h>
#include <linux/random.h>

int __init init_test( void ){
	printk( KERN_INFO "test driver init!!\n" );
	return 0;
}

void __exit cleanup_test( void ){
	printk( KERN_INFO "test driver cleanup!!\n" );
}

module_init(init_test);
module_exit(cleanup_test);

