export type Book = { id:string; title:string; author:string; isbn?:string; year?:number; language?:string; publisher?:string; description?:string; coverPath?:string; sourcePdf:string; epubPath?:string; azw3Path?:string; importedAt:string; pages?:number; metadataSource:string; fingerprint:string };
export type BookDraft = Omit<Book,'id'|'importedAt'|'fingerprint'> & { coverData?: string };
export type ImportStage = 'waiting'|'validating'|'extracting'|'metadata'|'cover'|'converting'|'done'|'error'|'needs-review';
export type ImportJob = { id:string; source:string; name:string; progress:number; stage:ImportStage; error?:string; draft?:BookDraft; duplicate?:Book };
export type Metadata = Pick<Book,'title'|'author'|'isbn'|'year'|'language'|'publisher'|'description'|'metadataSource'> & { subjects?:string[]; coverUrl?:string; confidence:number };
