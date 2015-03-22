/*
 * This is sample code generated by rpcgen.
 * These are only templates and you can use them
 * as a guideline for developing your own functions.
 */

#include "file.h"


FILE*
fileprog_1(char *host, char* filename, char* filemode)
{
	CLIENT *clnt;
	file_open_request_res  *result_1;
	file_open_request  openfile_1_arg;
    
    openfile_1_arg.name = filename;
    openfile_1_arg.mode = filemode;

#ifndef	DEBUG
	clnt = clnt_create (host, FILEPROG, DIRVERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

	result_1 = openfile_1(&openfile_1_arg, clnt);
	if (result_1 == (file_open_request_res *) NULL) {
		clnt_perror (clnt, "call failed");
	}
    
    
    printf("file opened , %d, file handle: %x\n", result_1->errno, result_1->file_open_request_res_u.file_ptr);
    
    xdr_free(xdr_file_open_request_res, result_1);
#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */

    return (FILE*) result_1->file_open_request_res_u.file_ptr;
}


void
fileprog_2(char *host, FILE* file)
{
	CLIENT *clnt;
	file_close_request_res  *result_1;
	file_close_request  closefile_1_arg;
    
    closefile_1_arg.file_ptr = file;

#ifndef	DEBUG
	clnt = clnt_create (host, FILEPROG, DIRVERS, "udp");
	if (clnt == NULL) {
		clnt_pcreateerror (host);
		exit (1);
	}
#endif	/* DEBUG */

	result_1 = closefile_1(&closefile_1_arg, clnt);
	if (result_1 == (file_close_request_res *) NULL) {
		clnt_perror (clnt, "call failed");
	}
    
    
    printf("file closed , %d, file handle: %x\n", result_1->errno, result_1->file_close_request_res_u.ret);
    
    xdr_free(xdr_file_close_request_res, result_1);
#ifndef	DEBUG
	clnt_destroy (clnt);
#endif	 /* DEBUG */
}

int
main (int argc, char *argv[])
{
	char *host;

	if (argc < 2) {
		printf ("usage: %s server_host\n", argv[0]);
		exit (1);
	}
	host = argv[1];
    
    char* filename = argv[2];
    char* filemode = argv[3];
    FILE* f = fileprog_1 (host, filename, filemode);
    fileprog_2(host, f);
    
exit (0);
}
