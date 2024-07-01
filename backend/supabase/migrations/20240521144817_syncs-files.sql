create table "public"."syncs_files" (
    "id" bigint generated by default as identity not null,
    "syncs_active_id" bigint not null,
    "last_modified" timestamp with time zone not null default (now() AT TIME ZONE 'utc'::text),
    "brain_id" uuid default gen_random_uuid(),
    "path" text not null
);


alter table "public"."syncs_files" enable row level security;

alter table "public"."syncs_active" add column "brain_id" uuid;

CREATE UNIQUE INDEX sync_files_pkey ON public.syncs_files USING btree (id);

alter table "public"."syncs_files" add constraint "sync_files_pkey" PRIMARY KEY using index "sync_files_pkey";

alter table "public"."syncs_active" add constraint "public_syncs_active_brain_id_fkey" FOREIGN KEY (brain_id) REFERENCES brains(brain_id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."syncs_active" validate constraint "public_syncs_active_brain_id_fkey";

alter table "public"."syncs_files" add constraint "public_sync_files_brain_id_fkey" FOREIGN KEY (brain_id) REFERENCES brains(brain_id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."syncs_files" validate constraint "public_sync_files_brain_id_fkey";

alter table "public"."syncs_files" add constraint "public_sync_files_sync_active_id_fkey" FOREIGN KEY (syncs_active_id) REFERENCES syncs_active(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."syncs_files" validate constraint "public_sync_files_sync_active_id_fkey";

grant delete on table "public"."syncs_files" to "anon";

grant insert on table "public"."syncs_files" to "anon";

grant references on table "public"."syncs_files" to "anon";

grant select on table "public"."syncs_files" to "anon";

grant trigger on table "public"."syncs_files" to "anon";

grant truncate on table "public"."syncs_files" to "anon";

grant update on table "public"."syncs_files" to "anon";

grant delete on table "public"."syncs_files" to "authenticated";

grant insert on table "public"."syncs_files" to "authenticated";

grant references on table "public"."syncs_files" to "authenticated";

grant select on table "public"."syncs_files" to "authenticated";

grant trigger on table "public"."syncs_files" to "authenticated";

grant truncate on table "public"."syncs_files" to "authenticated";

grant update on table "public"."syncs_files" to "authenticated";

grant delete on table "public"."syncs_files" to "service_role";

grant insert on table "public"."syncs_files" to "service_role";

grant references on table "public"."syncs_files" to "service_role";

grant select on table "public"."syncs_files" to "service_role";

grant trigger on table "public"."syncs_files" to "service_role";

grant truncate on table "public"."syncs_files" to "service_role";

grant update on table "public"."syncs_files" to "service_role";

create policy "syncs_active"
on "public"."syncs_active"
as permissive
for all
to service_role;


create policy "syncs_user"
on "public"."syncs_user"
as permissive
for all
to service_role;
