import path from 'node:path';
export const sanitizeFilename=(value:string)=>value.normalize('NFKD').replace(/[\\/:*?"<>|\x00-\x1f]/g,'').replace(/\s+/g,' ').trim().replace(/[. ]+$/,'').slice(0,120)||'Untitled';
export const containedPath=(base:string, target:string)=>{ const relative=path.relative(path.resolve(base),path.resolve(target)); return relative!==''&&!relative.startsWith('..')&&!path.isAbsolute(relative); };
export const safeChild=(base:string,...parts:string[])=>{ const result=path.resolve(base,...parts.map(sanitizeFilename)); if(!containedPath(base,result)) throw new Error('Unsafe library path'); return result; };
