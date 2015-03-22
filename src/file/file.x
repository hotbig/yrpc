/*
 * dir.x: Remote directory listing protocol
 *
 * This example demonstrates the functions of rpcgen.
 */
 
const MAXNAMELEN = 255;						/* max length of directory entry */
typedef string filename<MAXNAMELEN>;
typedef string filemode<MAXNAMELEN>;

struct file_open_request{
    filename name;
    filemode mode;
};

struct file_close_request{
    int file_ptr;
};

typedef struct file_open_request file_open_request;
typedef struct file_close_request file_close_request;

union file_open_request_res switch (int errno) {
	case 0:
		int file_ptr;		/* no error: return directory listing */
	default:
		void;			/* error occurred: nothing else to return */
};

union file_close_request_res switch (int errno) {
	case 0:
		int ret;		/* no error: return directory listing */
	default:
		void;			/* error occurred: nothing else to return */
};
    
program FILEPROG {
	version DIRVERS {
		file_open_request_res
		OPENFILE(file_open_request) = 1;
        file_close_request_res
        CLOSEFILE(file_close_request) = 2;
	} = 1;} = 0x20000077; 
    
