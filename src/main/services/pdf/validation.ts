import { promises as fs } from 'node:fs';
import path from 'node:path';
export const MAX_PDF_BYTES=250*1024*1024;
export async function validatePdf(file:string){ if(path.extname(file).toLowerCase()!=='.pdf') throw new Error('Only PDF files can be imported'); const stat=await fs.stat(file); if(!stat.isFile()) throw new Error('Import target is not a file'); if(stat.size===0||stat.size>MAX_PDF_BYTES) throw new Error('PDF size is invalid or exceeds 250 MB'); const handle=await fs.open(file,'r'); try {const buffer=Buffer.alloc(5); await handle.read(buffer,0,5,0); if(buffer.toString()!=='%PDF-') throw new Error('File content is not a PDF');} finally {await handle.close();} return stat; }
