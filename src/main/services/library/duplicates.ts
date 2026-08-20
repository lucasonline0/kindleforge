import type { Book, BookDraft } from '../../../shared/types';
export const normalize=(value:string='')=>value.normalize('NFKD').replace(/[\u0300-\u036f]/g,'').toLowerCase().replace(/[^a-z0-9]/g,'');
export function findDuplicate(draft:BookDraft, books:Book[]){ return books.find(b=>(draft.isbn&&b.isbn&&draft.isbn===b.isbn)||(normalize(draft.title)===normalize(b.title)&&normalize(draft.author)===normalize(b.author))||(draft.sourcePdf===b.sourcePdf)); }
