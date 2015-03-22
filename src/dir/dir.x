/*
 * dir.x: Remote directory listing protocol
 *
 * This example demonstrates the functions of rpcgen.
 */
 
const MAXNAMELEN = 255;						/* max length of directory entry */
typedef string nametype<MAXNAMELEN>;		/* director entry */
typedef struct namenode *namelist;			/* link in the listing */
typedef string filename<MAXNAMELEN>;
typedef string filemode<MAXNAMELEN>;
typedef struct file_open_request file_open_request;
 
/* A node in the directory listing */
struct namenode {
	nametype name;						/* name of directory entry */
	namelist next;						/* next entry */
};

struct file_open_request{
    filename name;
    filemode mode;
};

union file_open_request_res switch (int errno) {
	case 0:
		char* file_ptr;		/* no error: return directory listing */
	default:
		void;			/* error occurred: nothing else to return */
};

/*
 * The result of a READDIR operation
 *
 * a truly portable application would use
 * an agreed upon list of error codes
 * rather than (as this sample program
 * does) rely upon passing UNIX errno's
 * back.
 *
 * In this example: The union is used 
 * here to discriminate between successful
 * and unsuccessful remote calls.
 */
 union readdir_res switch (int errno) {
	case 0:
		namelist list;		/* no error: return directory listing */
	default:
		void;			/* error occurred: nothing else to return */
};
 /* The directory program definition */
program DIRPROG {
	version DIRVERS {
		readdir_res
		READDIR(nametype) = 1;
	} = 1;} = 0x20000076; 
    
    
program FILEPROG {
	version DIRVERS {
		file_open_request_res
		OPENFILE(file_open_request) = 1;
	} = 1;} = 0x20000077; 